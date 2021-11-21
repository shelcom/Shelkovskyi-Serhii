//
//  TaskListViewController.swift
//  ToDo List
//
//  Created by Serhii on 25.10.2021.
//

import UIKit

class TaskListViewController: BaseViewController {
   
   @IBOutlet var tableView: UITableView!
   
   var taskController = TaskController()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      navigationController?.navigationBar.isHidden = true
   
      prepareTableView()
   }
   
   func prepareTableView() {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(UINib.init(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
   }
   
}

extension TaskListViewController : UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      taskController.tasksCount()
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskTableViewCell
      cell.fill(with: taskController.task(by: indexPath.row))
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         taskController.remove(by: indexPath.row)
         self.tableView.deleteRows(at: [indexPath], with: .left)
      }
   }
}
