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
    
    static let medicineSectionModel = "MedicineSectionModel"

    init(networkManager: ToFarmaManager = ToFarmaManager()) {
        self.medications = networkManager.fetchTodayMedication()
            .asDriver(onErrorDriveWith: .empty())
            .debug("datos", trimOutput: false)
            .map { medicationTime -> [MedicationSection] in
                var sections: [MedicationSection] = []
                
                medicationTime.keys.forEach { key in
                    guard let medication = medicationTime[key] else { return }
                    let section = MedicationSection(header: key, items: medication)
                    sections.append(section)
                }
                return sections
            }
        
        dataSheet = touchDataSheet
            .asDriver(onErrorDriveWith: .empty())
    }
}
