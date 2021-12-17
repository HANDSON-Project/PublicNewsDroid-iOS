//
//  CommentsViewController.swift
//  HandsOnProject
//
//  Created by Yundong Lee on 2021/12/17.
//

import UIKit

class CommentsViewController: UIViewController {

    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var commentsTableView: UITableView!
    var nickName: String?
    
    var comments : [String] = []
    var writer : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func confirmButton(_ sender: UIButton) {
        comments.append(commentText.text!)
        writer.append(nickName!)
        
        commentsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}


extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as? CommentTableViewCell else {  return UITableViewCell() }
        
        cell.writer.text = writer[indexPath.row]
        cell.content.text = comments[indexPath.row]
        
        return cell
    }
}
