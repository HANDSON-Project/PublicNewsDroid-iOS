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
    var nickName: String?
    
    
    
    @IBOutlet weak var newsContent: UILabel!
    override func viewDidLayoutSubviews() {
        newsContent.sizeToFit()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(jwt, userIdx, newsID)
        seeCertainNews()
        
        
    }
    
    
    @IBAction func commentButtonClicked(_ sender: UIButton) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as? CommentsViewController else { return }
        
    
        vc.nickName = nickName
        vc.newsID = newsID
        vc.jwt = jwt
        vc.userId = userIdx

        navigationController?.pushViewController(vc, animated: true)
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

    
//    func reportNews() {
//                   let url = "https://sindy-nick.site/app/news/\(userIdx!)"
//                   var request = URLRequest(url: URL(string: url)!)
//                   request.httpMethod = "POST"
//                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//                   request.timeoutInterval = 10
//
//            let headers: HTTPHeaders = [
//                       "X-ACCESS-TOKEN":jwt!
//                   ]
//
//
//                let parameters = [
//                    "userIdx":userIdx!,
//                    "title": title,
//                    "context":content,
//                    "image": "DSfasdf",
//                    "location":location!] as [String : Any]
//
//                   // httpBody 에 parameters 추가
//                   do {
//                       request.headers = headers
//                       try request.httpBody = JSONSerialization.data(withJSONObject: parameters, options: [])
//                   } catch {
//                       print("http Body Error")
//                   }
//
//
//            AF.request(request).responseString { (response) in
//                       switch response.result {
//                       case .success:
//                           print(request)
//                           print("POST 성공")
//                           print(response.result)
//                       case .failure(let error):
//                           print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
//                       }
//                   }
//               }
    
    @IBAction func reportButtonClicked(_ sender: UIBarButtonItem) {
        
        
        
    }
    
    
    
    // MARK: only show this button when the owner of the news is seeing.
    @IBAction func barButton(_ sender: UIBarButtonItem) {
    }
}
