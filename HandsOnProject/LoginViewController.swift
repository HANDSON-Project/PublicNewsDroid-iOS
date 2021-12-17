//
//  LoginViewController.swift
//  HandsonProject
//
//  Created by Yundong Lee on 2021/11/08.
//

import UIKit
import SwiftyJSON
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logInButtonClicked(_ sender: UIButton) {

        if let email = userIdTextField.text, let password = userPasswordTextField.text{
            print(email, password)
            login(email: email, password: password)
        }
        
        
        
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "Chat") as! UserListViewController
//        
//        vc.modalPresentationStyle = .fullScreen
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func login(email: String, password: String) {
            var url = "https://sindy-nick.site/app/user/log-in"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10
            
            // POST 로 보낼 정보
//            let params = ["id":"아이디", "pw":"패스워드"] as Dictionary
            let params: [String: String] = [
                "email": email,
                "password": password,
            ]
            // httpBody 에 parameters 추가
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                print("http Body Error")
            }
            
       
        
            AF.request(request).responseString { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    print("POST 성공")

                    
                    let innerJSON = JSON(parseJSON: json.stringValue)
                    let k = innerJSON["result"]
                    
                    let code = innerJSON["code"].intValue
                    let jwt = k["jwt"].stringValue
                    let userIdx = k["userIdx"].intValue
                    
        
                    
                    if code == 1000{

                        print("good to go")
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        
                        let vc = sb.instantiateViewController(withIdentifier: "Chat") as! UserListViewController
                        
                        print(jwt, userIdx)
                        vc.jwt = jwt
                        vc.userIdx = userIdx

                        vc.modalPresentationStyle = .fullScreen
                        
                        self.navigationController?.pushViewController(vc, animated: true)

                    }else{
                        print("not good")
                    }
//
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
        }

    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
//                print(error.localizedDescription)
            }
        }
        return nil
    }

}

//{
//  "jwt" : "eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWR4Ijo3LCJpYXQiOjE2Mzk3MDQ4MDcsImV4cCI6MTY0MTE3NjAzNn0.G9wboHa1Nv5GjR5ZrIeHDaJXtqIdOsdXjrwYGjxydjw",
//  "userIdx" : 7
//}
//ASdfadsf
//{
//  "isSuccess" : true,
//  "result" : {
//    "jwt" : "eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWR4Ijo3LCJpYXQiOjE2Mzk3MDQ4MDcsImV4cCI6MTY0MTE3NjAzNn0.G9wboHa1Nv5GjR5ZrIeHDaJXtqIdOsdXjrwYGjxydjw",
//    "userIdx" : 7
//  },
//  "message" : "ìì²­ì ì±ê³µíììµëë¤.",
//  "code" : 1000
//}
