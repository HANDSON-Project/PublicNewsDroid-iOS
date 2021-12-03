//
//  ChatViewController.swift
//  HandsonProject
//
//  Created by Yundong Lee on 2021/11/08.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var chatListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
       
    }
    


}


extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        
        // MARK: cell init things.
        
        cell.userNameLabel.text = "asdf"
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
}
