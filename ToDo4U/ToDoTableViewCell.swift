//
//  ToDoTableViewCell.swift
//  ToDo4U
//
//  Created by IFOCUS on 1/23/23.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var todoListLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
