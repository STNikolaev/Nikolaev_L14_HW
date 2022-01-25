

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currentPatientLabel: UILabel!
    
    @IBOutlet weak var numberOfPatientsLabel: UILabel!
    
    let hospital = Hospital()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hospital.delegate = self
        hospital.start()
        
    }
    
    @IBAction func addPatientsButton(_ sender: Any) {
        hospital.addNewPatient()
        numberOfPatientsLabel.text = " Patients in Queue: \(hospital.patientQueue.storage.count)"
    }
    
}

extension ViewController: HospitalDelegate {
    
    
    func currentPatientDidChange(patient: Patient) {
        currentPatientLabel.text = "Current patient: \(patient.name)"
        numberOfPatientsLabel.text = " Patients in Queue: \(hospital.patientQueue.storage.count)"
        
    }
    
    func workDayDidFinish() {
        currentPatientLabel.text = "All patients have been incured!"
    }
    
}
