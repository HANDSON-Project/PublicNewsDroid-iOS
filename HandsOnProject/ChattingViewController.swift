//
//  ChattingViewController.swift
//  HandsonProject
//
//  Created by Yundong Lee on 2021/11/08.
//

import UIKit

class ChattingViewController: UIViewController {

    var newsTitle = "제목"
    
    @IBOutlet weak var newsContent: UILabel!
    override func viewDidLayoutSubviews() {
        newsContent.sizeToFit()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = newsTitle
        

    }
    
    // MARK: only show this button when the owner of the news is seeing.
    @IBAction func barButton(_ sender: UIBarButtonItem) {
    }
}
