//
//  LoginViewController.swift
//  HandsonProject
//
//  Created by Yundong Lee on 2021/11/08.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userIdTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logInButtonClicked(_ sender: UIButton) {
        
        // MARK: need user verification.
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Chat")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
