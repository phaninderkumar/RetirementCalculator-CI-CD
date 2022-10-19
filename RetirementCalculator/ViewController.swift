//
//  ViewController.swift
//  RetirementCalculator
//
//  Created by Phaninder on 18/10/22.
//

import UIKit
import AppCenterAnalytics
import AppCenterCrashes

class ViewController: UIViewController {

    @IBOutlet weak var monthlyInvestmentsTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var retirementAgeTextField: UITextField!
    @IBOutlet weak var interestRateTextField: UITextField!
    @IBOutlet weak var savingsTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if AppCenterCrashes.Crashes.hasCrashedInLastSession {
            let alert = UIAlertController(title: "Oops", message: "Sorry about that, an error occured.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "It's cool", style: .default))
            self.present(alert, animated: true)
        }
        
        Analytics.trackEvent("navigated_to_calculator")
    }

    @IBAction func calculateButton_TouchUpInside(_ sender: Any) {
        let current_age: Int? = Int(ageTextField.text!)
        let planned_retirement_age: Int? = Int(retirementAgeTextField.text!)
        let monthly_investment: Float? = Float(monthlyInvestmentsTextField.text!)
        let current_savings: Float? = Float(savingsTextField.text!)
        let interest_rate: Float? = Float(interestRateTextField.text!)
                
        resultLabel.text = "If you save $\(monthly_investment!) every month for \(planned_retirement_age! - current_age!) years, and invest that money plus your current investment of \(current_savings!) at a \(interest_rate!)% annual interest rate, you will have $X by the time you are \(planned_retirement_age!)"
        
        let properties = ["current_age": String(current_age!),
                          "planned_retirement_age": String(planned_retirement_age!)]
        
        Analytics.trackEvent("calculate_retirement_amount", withProperties: properties)
    }
    
}

