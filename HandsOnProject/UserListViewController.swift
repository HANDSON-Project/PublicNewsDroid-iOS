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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.delegate = self
        usersTableView.dataSource = self

        
        let url1 = "https://sindy-nick.site/app/user?location=서울"
       if let encoded = url1.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
        {
           AF.request(url, method: .get).validate().responseJSON { response in
               switch response.result {
               case .success(let value):
                   let json = JSON(value)
                   print("good")
//                   print("JSON: \(json)")
//                   print(json["result"].arrayValue)
                   
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
        vc.userIdx = userIdx
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        
        // MARK: cell init things.
        cell.userStatusLabel.text = "오늘의 뉴스"
        cell.userNameLabel.text = "오늘의 특별한 장소를 소개합니다"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ChattingViewController") as? ChattingViewController else { return }
        
        vc.jwt = jwt
        vc.userIdx = userIdx
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
}


//{
//  "result" : [
//    {
//      "location" : "서울",
//      "email" : "tester0@email.com",
//      "userIdx" : 1,
//      "nickname" : "테스터",
//      "password" : "hr08DdPtS\/P2NK2\/jpakHw=="
//    },
//    {
//      "location" : "서울",
//      "email" : "tester10@email.com",
//      "userIdx" : 2,
//      "nickname" : "테스터",
//      "password" : "hr08DdPtS\/P2NK2\/jpakHw=="
//    },
//    {
//      "location" : "서울",
//      "email" : "tester1@email.com",
//      "userIdx" : 3,
//      "nickname" : "테스터",
//      "password" : "hr08DdPtS\/P2NK2\/jpakHw=="
//    },
//    {
//      "location" : "서울",
//      "email" : "tester5@email.com",
//      "userIdx" : 4,
//      "nickname" : "테스터",
//      "password" : "hr08DdPtS\/P2NK2\/jpakHw=="
//    },
//    {
//      "location" : "서울",
//      "email" : "tester4@email.com",
//      "userIdx" : 5,
//      "nickname" : "테스터",
//      "password" : "hr08DdPtS\/P2NK2\/jpakHw=="
//    },
//    {
//      "location" : "서울",
//      "email" : "tester7@email.com",
//      "userIdx" : 8,
//      "nickname" : "테스터",
//      "password" : "hr08DdPtS\/P2NK2\/jpakHw=="
//    }
//  ],
//  "message" : "요청에 성공하였습니다.",
//  "isSuccess" : true,
//  "code" : 1000
//}

//
//{
//    "isSuccess": true,
//    "code": 1000,
//    "message": "요청에 성공하였습니다.",
//    "result": [
//        {
//            "userIdx": 1,
//            "nickname": "테스터",
//            "email": "tester0@email.com",
//            "password": "hr08DdPtS/P2NK2/jpakHw==",
//            "location": "서울"
//        },
//        {
//            "userIdx": 2,
//            "nickname": "테스터",
//            "email": "tester10@email.com",
//            "password": "hr08DdPtS/P2NK2/jpakHw==",
//            "location": "서울"
//        },
//        {
//            "userIdx": 3,
//            "nickname": "테스터",
//            "email": "tester1@email.com",
//            "password": "hr08DdPtS/P2NK2/jpakHw==",
//            "location": "서울"
//        },
//        {
//            "userIdx": 4,
//            "nickname": "테스터",
//            "email": "tester5@email.com",
//            "password": "hr08DdPtS/P2NK2/jpakHw==",
//            "location": "서울"
//        },
//        {
//            "userIdx": 5,
//            "nickname": "테스터",
//            "email": "tester4@email.com",
//            "password": "hr08DdPtS/P2NK2/jpakHw==",
//            "location": "서울"
//        },
//        {
//            "userIdx": 8,
//            "nickname": "테스터",
//            "email": "tester7@email.com",
//            "password": "hr08DdPtS/P2NK2/jpakHw==",
//            "location": "서울"
//        }
//    ]
//}
