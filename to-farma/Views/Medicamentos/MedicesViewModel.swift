//
//  MedicesViewModel.swift
//  to-farma
//
//  Created by Melissa Villalobos on 19/6/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct MedicationSection {
    var header: String
    var items: [Medication]
}

extension MedicationSection: SectionModelType {
    typealias Item = Medication
    init(original: MedicationSection, items: [Item]) {
        self = original
        self.items = items
    }
}

class MedicineViewModel{
    //Input
    let takeTime = PublishRelay<String>()
    let touchDataSheet = PublishRelay<(title: String?, dataSheet: String?)>()
    
    //Output
    var medications: Driver<[MedicationSection]>
    let dataSheet: Driver<(title: String?, dataSheet: String?)>
    let nextVisit: Driver<String>
    
    static let medicineSectionModel = "MedicineSectionModel"

    init(networkManager: ToFarmaManager = ToFarmaManager()) {
    
        let medicationList = networkManager.fetchTodayMedication()
            .asDriver(onErrorDriveWith: .empty())
            .compactMap { medicationTime -> [Dictionary<Date, [Medication]>.Element] in
                return medicationTime.sorted { $0.key.compare($1.key) == .orderedAscending }
            }
        
        nextVisit = networkManager.fetchNextVisit()
            .map { $0.date }
            .asDriver(onErrorDriveWith: .empty())
        
        self.medications = medicationList
            .map { medicationTime -> [MedicationSection] in
                
                var sections: [MedicationSection] = []
                
                medicationTime.forEach { key, value in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "h:mm a"

                    let dateString = dateFormatter.string(from: key)

                    let section = MedicationSection(header: dateString, items: value)
                    sections.append(section)
                }
                return sections
            }
        
        dataSheet = touchDataSheet
            .asDriver(onErrorDriveWith: .empty())
    }
}
