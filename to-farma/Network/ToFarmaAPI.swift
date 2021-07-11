//
//  ToFarmaProvider.swift
//  to-forma
//
//  Created by Melissa Villalobos on 20/5/21.
//

import Foundation
import Moya

enum ToFarmaAPI {
    case token(username: String, password: String)
    case blog
    case user
    case productsCategory(category: String)
    case getCurrentOrder
    case doctorPatients
    case doctorPatientsNextVisit(patient: Int)
    case doctorTodayMedication(patient: Int)
    case patientNextVisit
    case patientTodayMedication
    case usedCategories
    case userMessages
    case currentMedicationNotify
    case postCurrentOrder
    case FCMDeviceToken
    case patientMessages
    case patientRegister
}

extension ToFarmaAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://admin.tofarma.com") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .blog:
            return "/api/post"
        case .user:
            return "/api/user"
        case .token:
            return "/oauth/token"
        case .productsCategory(let category):
            return "api/category/\(category)/products"
        case .getCurrentOrder:
            return "api/order/current"
        case .doctorPatients:
            return "api/doctor/patients"
        case .doctorPatientsNextVisit(let patient):
            return "api/doctor/patient/\(patient)/next-visit"
        case .doctorTodayMedication(let patient):
            return "api/doctor/patient/\(patient)/todayMedication"
        case .patientNextVisit:
            return "api/patient/next-visit"
        case .patientTodayMedication:
            return "api/patient/todayMedication"
        case .usedCategories:
            return "api/category/used"
        case .userMessages:
            return "api/patient/messages"
        case .currentMedicationNotify:
            return "api/patient/medicationNotify"
        case .postCurrentOrder:
            return "api/order/current"
        case .FCMDeviceToken:
            return "api/user/firebaseToken"
        case .patientMessages:
            return "api/patient/messages"
        case .patientRegister:
            return "api/patient/register"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .token, .currentMedicationNotify, .postCurrentOrder, .FCMDeviceToken, .patientMessages, .patientRegister:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .token(let username, let password):
                return .requestParameters(
                    parameters: [
                        "client_id": Environment.shared.configuration(.client)!,
                        "client_secret": Environment.shared.configuration(.secret)!,
                        "grant_type": Environment.shared.configuration(.grantType)!,
                        "scope": Environment.shared.configuration(.scope)!,
                        "password": password,
                        "username": username
                    ], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .token:
            return ["Content-Type": "application/json"]
        case .blog,
             .user,
             .productsCategory,
             .postCurrentOrder,
             .doctorPatients,
             .doctorPatientsNextVisit,
             .getCurrentOrder,
             .doctorTodayMedication,
             .patientNextVisit,
             .patientTodayMedication,
             .usedCategories,
             .userMessages,
             .currentMedicationNotify,
             .FCMDeviceToken,
             .patientMessages,
             .patientRegister:
            return ["Authorization": "Bearer "+(KeychainServicesManager.fetchAuthToken() ?? "")]
        }
    }
}
