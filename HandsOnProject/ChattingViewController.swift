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
    var newsID:Int?
    
    
    @IBOutlet weak var newsContent: UILabel!
    override func viewDidLayoutSubviews() {
        newsContent.sizeToFit()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(jwt, userIdx, newsID)
        seeCertainNews()
        
        
    }
    
    func seeCertainNews() {
        let url1 = "https://sindy-nick.site/app/news/\(newsID!)"
                  if let encoded = url1.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
                   {
                      AF.request(url, method: .get).validate().responseJSON { response in
                          switch response.result {
                          case .success(let value):
                              let json = JSON(value)
                              print("good")
                              print("JSON: \(json)")
                              
                              
                              DispatchQueue.main.async {

                                  self.title = json["result"]["title"].stringValue
                                  self.newsContent.text = json["result"]["context"].stringValue
                              
                              }
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
