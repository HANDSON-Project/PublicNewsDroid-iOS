//
//  CommentTableViewCell.swift
//  HandsOnProject
//
//  Created by Yundong Lee on 2021/12/17.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var writer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
