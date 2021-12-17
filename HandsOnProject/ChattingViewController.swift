//
//  ChattingViewController.swift
//  HandsonProject
//
//  Created by Yundong Lee on 2021/11/08.
//

import UIKit
import SwiftyJSON
import Alamofire

class ChattingViewController: UIViewController {

    var jwt: String?
    var userIdx: Int?
    
    @IBOutlet weak var newsContent: UILabel!
    override func viewDidLayoutSubviews() {
        newsContent.sizeToFit()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seeCertainNews()

    }
    
    func seeCertainNews() {
        var url1 = "https://sindy-nick.site/app/users?location=서울"
                if let encoded = url1.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
                 {
                    AF.request(url, method: .get).validate().responseJSON { response in
                        switch response.result {
                        case .success(let value):
                            let json = JSON(value)
                            print("good")
                            print("JSON: \(json)")
                        case .failure(let error):
                            print("not good")
                            print(error)
                        }
                    }
                 }
    }
    
    @IBAction func reportButtonClicked(_ sender: UIBarButtonItem) {
    }
    
    // MARK: only show this button when the owner of the news is seeing.
    @IBAction func barButton(_ sender: UIBarButtonItem) {
    }
}
