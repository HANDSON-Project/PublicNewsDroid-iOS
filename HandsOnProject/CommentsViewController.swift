//
//  CommentsViewController.swift
//  HandsOnProject
//
//  Created by Yundong Lee on 2021/12/17.
//

import UIKit
import Alamofire
import SwiftyJSON

class CommentsViewController: UIViewController {

    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var commentsTableView: UITableView!
    
    var nickName: String?
    var newsID: Int?
    var userId: Int?
    var jwt: String?
    var data: [JSON] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seeComment()
        self.title = "댓글"
        commentsTableView.rowHeight = UITableView.automaticDimension
    }

    @IBAction func confirmButton(_ sender: UIButton) {

        createComment()
    }
    
    func createComment(){
           let url = "https://sindy-nick.site/app/news/comments"
           var request = URLRequest(url: URL(string: url)!)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           request.timeoutInterval = 10
    
    let headers: HTTPHeaders = [
               "X-ACCESS-TOKEN":jwt!
           ]
           

        let parameters = [
            "newsIdx": newsID!,
            "userIdx": userId!,
            "content":commentText.text!
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
               case .success:
                   print(request)
                   print("POST 성공")
                   self.seeComment()
               case .failure(let error):
                   print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
               }
           }
        }
    
    func seeComment() {
            let url1 = "https://sindy-nick.site/app/news/comments/\(newsID!)"

               if let encoded = url1.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded)
                {
                   AF.request(url, method: .get).validate().responseJSON { response in
                       switch response.result {
                       case .success(let value):
                           let json = JSON(value)
                           print("JSON: \(json)")
                           self.data = json["result"].arrayValue
                           DispatchQueue.main.async {
                               self.commentsTableView.reloadData()
                           }
         
                       case .failure(let error):
                           print("not good")
                           print(error)
                       }
                   }
                }
        }
    
   
}


extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as? CommentTableViewCell else {  return UITableViewCell() }
        
        cell.writer.text = data[indexPath.row]["nickname"].stringValue
        cell.content.text = data[indexPath.row]["context"].stringValue
        let date = data[indexPath.row]["createdAt"].stringValue
        let index = date.firstIndex(of: "T")!
        cell.dateLabel.text = String(date[..<index])
        
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        70
//    }
}
