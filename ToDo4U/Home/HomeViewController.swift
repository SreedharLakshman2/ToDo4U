//
//  HomeViewController.swift
//  ToDo4U
//
//  Created by IFOCUS on 1/31/23.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var listTableView: UITableView!
    var toDoListViewModel: ToDoListViewModel = ToDoListViewModel()
    private var todoTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
        registerTableViewCell()
    }
    
    func registerTableViewCell() {
        listTableView.dataSource = self
        listTableView.delegate = self
         listTableView.register(UINib(nibName: "ToDoListTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoListTableViewCell")
        navigationController?.title = "Organise your tasks"
      }
    
    @IBAction func addTaskButtonAction(_ sender: Any) {
        let alertViewController = UIAlertController.init(title: "Add Task", message: "", preferredStyle: .alert)
        alertViewController.addTextField { textField in
            self.todoTextField = textField
            self.todoTextField?.delegate = self
            self.todoTextField?.placeholder = "Enter Task"
        }
        let action = UIAlertAction.init(title: "Ok", style: .default) { action in
            if (self.todoTextField?.text != "") {
                self.toDoListViewModel.toDoArray.append(ToDoItemModel(toDoDescription: self.todoTextField?.text ?? "", isDone: false))
                self.listTableView.reloadData()
             }
        }
        alertViewController.addAction(action)
        present(alertViewController, animated: true, completion:nil)
    }
    
}




extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = listTableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCell", for: indexPath) as? ToDoListTableViewCell else { return UITableViewCell() }
        cell.completeTaskDelegateProtocol = self
        cell.deleteTaskDelegateProtocol = self
        switch indexPath.section {
        case 0:
            cell.toDoDescriptionLabel.text = "\(indexPath.row+1). "+toDoListViewModel.toDoArray[indexPath.row].toDoDescription
            cell.deleteToDoFromList.tag = indexPath.row
            cell.completeToDoFromList.tag = indexPath.row
            cell.deleteToDoFromList.isHidden = false
            cell.completeToDoFromList.isHidden = false
            
         default:
            cell.toDoDescriptionLabel.text = "\(indexPath.row+1). "+toDoListViewModel.completedtaskArray[indexPath.row].toDoDescription
            cell.deleteToDoFromList.isHidden = true
            cell.completeToDoFromList.isHidden = true
         }
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = section == 0 ? "ToDo" : "Completed"
        label.textColor = .black
        label.font = UIFont(name: "SparkyStones-Regular", size: 20)
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: footerView.frame.width-10, height: footerView.frame.height-10)
        label.text = (section == 0 && toDoListViewModel.toDoArray.count == 0) ? "NoData" : (section == 1 && toDoListViewModel.completedtaskArray.count == 0) ? "NoData" : ""
        label.textColor = .systemIndigo
        label.font = UIFont(name: "SparkyStones-Regular", size: 15)
        label.contentMode = .center
        footerView.addSubview(label)
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? toDoListViewModel.toDoArray.count : toDoListViewModel.completedtaskArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
}

extension HomeViewController: CompleteTaskDelegateProtocol,DeleteTaskDelegateProtocol {
    func completedTask(index: Int) {
        toDoListViewModel.completedtaskArray.append(toDoListViewModel.toDoArray[index])
        toDoListViewModel.toDoArray.remove(at: index)
        listTableView.reloadData()
    }
    func deletedTask(index: Int) {
        toDoListViewModel.toDoArray.remove(at: index)
        listTableView.reloadData()
    }
}
