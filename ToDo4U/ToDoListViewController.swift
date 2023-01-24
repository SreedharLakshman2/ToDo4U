//
//  ViewController.swift
//  ToDo4U
//
//  Created by IFOCUS on 09/01/23.
//

import UIKit

class ToDoListViewController: UITableViewController {
    var items: [String]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad")
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style:.plain, target: self, action: #selector(onClickMessageButton))]
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    override func viewWillLayoutSubviews() {
        
     print("viewWillLayoutSubviews")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    @objc func onClickMessageButton() {
        print("Message")
    }
}

extension ToDoListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as? ToDoTableViewCell
        if let itemArray = items {
            cell?.todoListLabel.text = itemArray[indexPath.row]
        }
        return cell ?? UITableViewCell()
    }
    
}

