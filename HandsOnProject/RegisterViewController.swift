//
//  RegisterViewController.swift
//  HandsonProject
//
//  Created by Yundong Lee on 2021/11/08.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet var numberTextField: UIView!
    @IBOutlet weak var locationPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationPicker.delegate = self
        locationPicker.dataSource = self
    }
    
    let location = ["서울", "경기", "충청남도",
                    "충청북도", "경상남도", "경상북도","전라남도","전라북도"
    ]
    
    
    @IBAction func registerButtonClicked(_ sender: UIButton) {
        
        
    }
    

}

extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        location.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        location[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

    
    
}


