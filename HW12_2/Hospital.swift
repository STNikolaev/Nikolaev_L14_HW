

import Foundation
import UIKit

protocol HospitalDelegate: AnyObject {
    func currentPatientDidChange(patient: Patient)
    func workDayDidFinish()
}

struct PatientQueue {
    var storage: [Patient] = []
    
    init(patients: [Patient]) {
        self.storage = patients
    }
    
    mutating func deque() -> Patient? {
        guard storage.count > 0 else { return nil}
        return storage.removeFirst()
    }
    
    mutating func enque(patient: Patient) {
        storage.append(patient)
    }
}


class Hospital {
    let doctor = Doctor(name: "Cox")
    var patientQueue: PatientQueue
    var newPatientQueue: PatientQueue
    weak var delegate: HospitalDelegate?
    
    init() {
        let patient1 = Patient(name: "Alexandr")
        let patient2 = Patient(name: "Alexey")
        let patient3 = Patient(name: "Andrey")
        let patient4 = Patient(name: "Artem")
        let patient5 = Patient(name: "Anton")
        let patient6 = Patient(name: "Albert")
        let patient7 = Patient(name: "Anufriy")
        let patient8 = Patient(name: "Avgustin")
        let patient9 = Patient(name: "Akakiy")
        let patient10 = Patient(name: "Arkadiy")
        let patient11 = Patient(name: "Aristarkh")
        let patient12 = Patient(name: "Agafon")
        
        patientQueue = PatientQueue(patients: [patient1, patient2, patient3, patient4, patient5, patient6])
        
        newPatientQueue = PatientQueue(patients: [patient7, patient8, patient9, patient10, patient11, patient12])
    }
    
    
    func start() {
        doctor.delegate = self
        guard let firstPatient = patientQueue.deque() else { return }
        examine(patient: firstPatient)
    }
    
    func examine(patient: Patient) {
        doctor.examine(patient: patient)
        delegate?.currentPatientDidChange(patient: patient)
    }
    func addNewPatient() {
        guard let newPatient = newPatientQueue.deque() else { return }
        patientQueue.enque(patient: newPatient)
    }
}


extension Hospital: DoctorDelegate {
    func patientExaminationDidEnd(patient: Patient) {
        print("Patient \(patient.name) has been successfuly examined by doctor.")
        guard let next = patientQueue.deque() else {
            doctor.workDayDidFinish()
            delegate?.workDayDidFinish()
            return
        }
        
        examine(patient: next)
    }
}

