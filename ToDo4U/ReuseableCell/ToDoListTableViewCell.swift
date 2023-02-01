//
//  ToDoListTableViewCell.swift
//  ToDo4U
//
//  Created by IFOCUS on 2/1/23.
//

import UIKit


protocol DeleteTaskDelegateProtocol {
    func deletedTask(index: Int)
}

protocol CompleteTaskDelegateProtocol {
    func completedTask(index: Int)
}


class ToDoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var deleteToDoFromList: UIButton!
    @IBOutlet weak var completeToDoFromList: UIButton!
    @IBOutlet weak var toDoDescriptionLabel: UILabel!
    
    var deleteTaskDelegateProtocol: DeleteTaskDelegateProtocol!
    var completeTaskDelegateProtocol: CompleteTaskDelegateProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func completedTaskFromListAction(_ sender: UIButton) {
        self.completeTaskDelegateProtocol.completedTask(index: sender.tag)
    }
    
    @IBAction func deletedTaskFromListAction(_ sender: UIButton) {
        self.deleteTaskDelegateProtocol.deletedTask(index: sender.tag)
    }
}
