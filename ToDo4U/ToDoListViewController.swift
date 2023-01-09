//
//  ViewController.swift
//  ToDo4U
//
//  Created by IFOCUS on 09/01/23.
//

import UIKit

class ToDoListViewController: UITableViewController {
    var items: [String] = [" python class", "VocabularyClass","BugFIx"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ToDoListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
}

