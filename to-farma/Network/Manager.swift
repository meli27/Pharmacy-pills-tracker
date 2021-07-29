//
//  Manager.swift
//  to-farma
//
//  Created by Melissa Villalobos on 23/5/21.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

protocol ToFarmaProtocol {
    var provider: MoyaProvider<ToFarmaAPI> { get }
    func fetchPosts() -> Observable<[Post]>
    func fetchUser() -> Observable<User>
    func fetchToken(username: String, password: String) -> Observable<AccessToken>
}

class ToFarmaManager: ToFarmaProtocol {
    var provider: MoyaProvider<ToFarmaAPI>
    static var shared = ToFarmaManager()

    init() {
        let authPlugin = AccessTokenPlugin { _ in "" }
        provider = MoyaProvider<ToFarmaAPI>(plugins: [authPlugin])
    }
   
    func fetchPosts() -> Observable<[Post]> {
        requestList(target: .blog)
    }
    
    func fetchUser() -> Observable<User> {
        request(target: .user)
    }
    
    func fetchTodayMedication() -> Observable<[Date : [Medication]]> {
        requestMedicines(target: .patientTodayMedication)
    }
    
    func fetchToken(username: String, password: String) -> Observable<AccessToken> {
        return request(target: .token(username: username, password: password))
    }
    
    func fetchMessages() -> Observable<[Message]> {
        requestList(target: .userMessages)
    }
    
    func fetchCategories() -> Observable<[Category]> {
        requestList(target: .usedCategories)
    }
    
    func fetchProduct(category: String) -> Observable<[Productos]> {
        requestList(target: .productsCategory(category: category))
    }
    
    func fetchNextVisit() -> Observable<Visit> {
        request(target: .patientNextVisit)
    }
}

private extension ToFarmaManager {
    private func request<T: Decodable>(target: ToFarmaAPI) -> Observable<T> {
        return Observable<T>.create { observer in
            self.provider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let model = try JSONDecoder().decode(T.self, from: response.data)
                        observer.on(.next(model))
                    } catch let error {
                        observer.onError(error)
                    }
                case .failure(let error):
                    return observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func requestMedicines(target: ToFarmaAPI) -> Observable<[Date : [Medication]]> {
        return Observable<[Date : [Medication]]>.create { observer in
            self.provider.request(target) { result in
                switch result {
                case .success(let response):

                    do {
                        let dictionary = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as! NSDictionary
                        var medicationsTime: [Date: [Medication]] = [:]

                        for key in dictionary.allKeys {
                            var medications: [Medication] = []
                            let values = dictionary.object(forKey: key) as! NSArray
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "h:mm a"
                            let date = dateFormatter.date(from: key as! String)!

                            var medicineObject: Medicine!
                          
                            for value in values {
                                let dose = (value as AnyObject).object(forKey: "dose") as! String
                                let medicines = (value as AnyObject).object(forKey: "medicine") as! NSDictionary
            
                                let id = (medicines as AnyObject).object(forKey: "id") as! Int?
                                let logo = (medicines as AnyObject).object(forKey: "logo") as! String?
                                let name = (medicines as AnyObject).object(forKey: "name") as! String?
                                let measurementUnits = (medicines as AnyObject).object(forKey: "measurementUnits") as! String?
                                let presentation = (medicines as AnyObject).object(forKey: "presentation") as! String?
                                let quantity = (medicines as AnyObject).object(forKey: "measurementUnits") as! Int?
                                let dataSheet = (medicines as AnyObject).object(forKey: "data_sheet") as? String
                                medicineObject = Medicine(id: id, logo: logo, name: name, measurementUnits: measurementUnits, presentation: presentation, quantity: quantity, dataSheet: dataSheet)
                
                                let medication = Medication(dose: dose, takeTime: date, medicine: medicineObject)
                                medications.append(medication)
                                medicationsTime[date] = medications
                            }
                            observer.onNext(medicationsTime)
                        }
                    } catch {
                        observer.onError(error)
                    }
                case .failure(let error):
                    return observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func requestList<T: Decodable>(target: ToFarmaAPI) -> Observable<[T]> {
        return Observable<[T]>.create { observer in
            self.provider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let model = try JSONDecoder().decode([T].self, from: response.data)
                        observer.on(.next(model))
                    } catch let error {
                        observer.onError(error)
                    }
                case .failure(let error):
                    return observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func decodeElement<T>(documentData: T) -> [String: Any]? where T: Encodable {
        guard
            let jsonData = try? JSONEncoder().encode(documentData),
            let jsonString = String(data: jsonData, encoding: .utf8),
            let jsonDictionary = createDictionary(from: jsonString)
        else {
            return nil
        }
        return jsonDictionary
    }

    func createDictionary(from: String) -> [String: Any]? {
        guard
            let data = from.data(using: .utf8),
            let element = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else {
            return nil
        }
        return element
    }
}
