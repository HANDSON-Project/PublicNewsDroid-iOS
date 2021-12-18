//
//  ChattingViewController.swift
//  HandsonProject
//
//  Created by Yundong Lee on 2021/11/08.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher

class ChattingViewController: UIViewController {

    var jwt: String?
    var userIdx: Int?
    var newsID:Int?
    var nickName: String?
    
    
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var newsContent: UILabel!
    override func viewDidLayoutSubviews() {
        newsContent.sizeToFit()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        newsContent.layer.borderWidth = 2
//        
//        newsContent.layer.borderColor = UIColor.black.cgColor
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
                                  let url = URL(string: json["result"]["image"].stringValue)
                                  self.newsImage.kf.setImage(with: url)
                              
                              }
                          case .failure(let error):
                              print("not good")
                              print(error)
                          }
                      }
                   }
       }

    
    func reportNews() {
                   let url = "https://sindy-nick.site/app/news/report/"
                   var request = URLRequest(url: URL(string: url)!)
                   request.httpMethod = "POST"
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                   request.timeoutInterval = 10

            let headers: HTTPHeaders = [
                       "X-ACCESS-TOKEN":jwt!
            ]


                let parameters = [
                    "userIdx":userIdx!,
                    "newsIdx": newsID!
                ] as [String : Any]

                   // httpBody 에 parameters 추가
                   do {
                       request.headers = headers
                       try request.httpBody = JSONSerialization.data(withJSONObject: parameters, options: [])
                   } catch {
                       print("http Body Error")
                   }


            AF.request(request).responseString { (response) in
                       switch response.result {
                       case .success(let value):
                           let json = JSON(value)
                           print("good")
                           print("JSON: \(json)")
                           let innerJSON = JSON(parseJSON: json.stringValue)
                           print(innerJSON)
                           if innerJSON["code"].intValue == 1000{
                               let alertVC = UIAlertController(title: "신고가 완료되었습니다.", message: "", preferredStyle: .alert)
                               
                               let fromGallaryButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                              
                               
                               alertVC.addAction(fromGallaryButton)
                               
                               self.present(alertVC, animated: true, completion: nil)
                               
                           }else{
                               
                           }
                           
                       case .failure(let error):
                           print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                       }
                }
               }
    
    @IBAction func reportButtonClicked(_ sender: UIBarButtonItem) {
        reportNews()
    }

}
    
  

