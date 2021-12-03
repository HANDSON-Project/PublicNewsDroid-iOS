//
//  UserTableViewCell.swift
//  HandsonProject
//
//  Created by Yundong Lee on 2021/11/08.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userStatusLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
