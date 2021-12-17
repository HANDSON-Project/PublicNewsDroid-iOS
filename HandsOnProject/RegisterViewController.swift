//
//  RegisterViewController.swift
//  HandsonProject
//
//  Created by Yundong Lee on 2021/11/08.
//

import UIKit
import Alamofire

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
    
    let location = [
        "서울특별시","부산광역시","인천광역시", "대구광역시", "대전광역시", "광주광역시","울산광역시","경기도","경기도", "강원도",
        "충청북도", "충청남도","전라남도","전라북도","경상남도", "경상북도"
    ]
    
    
    
    @IBAction func registerButtonClicked(_ sender: UIButton) {
        let id = idTextField.text!
        let password = passwordTextField.text!
        let email = emailTextField.text!
        let location = location[locationPicker.selectedRow(inComponent: 0)]
        
        
        
        Register(email: email, password: password, nickName: id, location: location)
        
    }
    
    func Register(email: String, password: String, nickName: String, location: String) {
                var url = "https://sindy-nick.site/app/user/sign-up"
                var request = URLRequest(url: URL(string: url)!)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.timeoutInterval = 10
                
                // POST 로 보낼 정보
    //            let params = ["id":"아이디", "pw":"패스워드"] as Dictionary
                let params: [String: String] = [
                    "email": email,
                    "password": password,
                    "nickname" : nickName,
                    "location": location
                    
                ] as Dictionary

                // httpBody 에 parameters 추가
                do {
                    try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
                } catch {
                    print("http Body Error")
                }
                
                AF.request(request).responseString { (response) in
                    switch response.result {
                    case .success:
                        print("POST 성공")
                        print(response.result)

                    case .failure(let error):
                        print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                    }
                }
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


