//
//  UserListViewController.swift
//  HandsonProject
//
//  Created by Yundong Lee on 2021/11/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserListViewController: UIViewController {
    
    
    @IBOutlet weak var usersTableView: UITableView!
    var jwt: String?
    var userIdx: Int?
    var location: String?
    var nickName: String?
    
    var data: [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.delegate = self
        usersTableView.dataSource = self
        
        self.title = location
        
       getData()
    }
    
    func getData() {
        let url1 = "https://sindy-nick.site/app/news?location=\(location!)"
       if let encoded = url1.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
        {
           AF.request(url, method: .get).validate().responseJSON { response in
               switch response.result {
               case .success(let value):
                   let json = JSON(value)
                   print("good")
                   self.data = json["result"].arrayValue
                   DispatchQueue.main.async {
                       self.usersTableView.reloadData()
                   }
                   
               case .failure(let error):
                   print("not good")
                   print(error)
               }
           }
        }
    }
    
    
    @IBAction func createButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        vc.jwt = jwt
        vc.location = location
        vc.userIdx = userIdx
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func reloadButton(_ sender: UIBarButtonItem) {
        getData()
    }
    
}


extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        
        let row = data[indexPath.row]
        cell.userNameLabel.text = row["title"].stringValue
        let content = row["context"].stringValue.replacingOccurrences(of: "\n", with: "")
        cell.userStatusLabel.text = content
        
        
        let url = URL(string: row["image"].stringValue)
        cell.userImage.kf.setImage(with: url)
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ChattingViewController") as? ChattingViewController else { return }
        
        vc.jwt = jwt
        vc.userIdx = userIdx
        vc.newsID = data[indexPath.row]["newsIdx"].intValue
        vc.nickName = nickName
        


        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
}

