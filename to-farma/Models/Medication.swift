//
//  Medication.swift
//  to-farma
//
//  Created by Melissa Villalobos on 27/6/21.
//

import Foundation

struct Medication: Codable {
    let id: Int?
    let presentation: String?
    let dose: String?
    let takeTime: Date?
    let medicine_id: Int?
    let patient_id: Int?
    let created_at: String?
    let updated_at: String?
    let medicine: Medicine?
    let timeRow: Bool
    
    init(dose: String, takeTime: Date?, medicine: Medicine?) {
        self.dose = dose
        self.takeTime = takeTime
        self.medicine = medicine
        self.id = 0
        self.presentation = ""
        self.medicine_id = 0
        self.patient_id = 0
        self.created_at = ""
        self.updated_at = ""
        self.timeRow = false
    }
    
    init(takeTime: Date?, timeRow: Bool) {
        self.dose = ""
        self.takeTime = takeTime
        self.timeRow = timeRow
        self.medicine = nil
        self.id = 0
        self.presentation = ""
        self.medicine_id = 0
        self.patient_id = 0
        self.created_at = ""
        self.updated_at = ""
    }
}
