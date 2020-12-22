//
//  GitApiCustomCell.swift
//  GMInterviewApplication
//
//  Created by PRANOTI KULKARNI on 12/21/20.
//

import UIKit

class GitApiCustomCell: UITableViewCell {
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var commitMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
