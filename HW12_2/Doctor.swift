
import Foundation

protocol DoctorDelegate: AnyObject {
    func patientExaminationDidEnd(patient: Patient)
}

class Doctor {
    let name: String
    var currentPatient: Patient?
    weak var delegate: DoctorDelegate?
    weak var timer: Timer?
    
    init(name: String, delegate: DoctorDelegate? = nil) {
        self.name = name
        self.delegate = delegate
    }
    
    func examine(patient: Patient) {
        self.timer = Timer.scheduledTimer(timeInterval: 3,
                                          target: self,
                                          selector: #selector(releasePatient),
                                          userInfo: nil,
                                          repeats: false)
        
        
        self.currentPatient = patient
        
        print("Doctor \(name) examines patient \(patient.name).")
    }
    
    func workDayDidFinish() {
        timer?.invalidate()
        print("Doctor goes home.")
    }
    
    @objc func releasePatient() {
        timer?.invalidate()
        
        if let currentPatient = currentPatient {
            delegate?.patientExaminationDidEnd(patient: currentPatient)
        }
    }
}
