//
//  TaskController.swift
//  ToDo List
//
//  Created by Serhii on 05.11.2021.
//

import Foundation

class TaskController {
   
   private var tasks: [Task] = [
      Task.init(title: "Some title", description: "Description1", taskDate: Date(), createdDate: Date(), status: "Done"),
      Task.init(title: "1 Some title", description: "Description2", taskDate: Date(), createdDate: Date(), status: "Progress"),
      Task.init(title: "2 Some title", description: "Description3", taskDate: Date(), createdDate: Date(), status: "Progress"),
      Task.init(title: "3 Some title", description: "Description4", taskDate: Date(), createdDate: Date(), status: "Progress"),
      Task.init(title: "New title", description: "Description5", taskDate: Date(), createdDate: Date(), status: "Progress"),
      Task.init(title: "Task", description: "Description6", taskDate: Date(), createdDate: Date(), status: "Done"),
      Task.init(title: "Read Book", description: "Description7", taskDate: Date(), createdDate: Date(), status: "Done"),
      Task.init(title: "Jump", description: "Description8", taskDate: Date(), createdDate: Date(), status: "Progress"),
      Task.init(title: "Sport", description: "Description9", taskDate: Date(), createdDate: Date(), status: "Done"),
      Task.init(title: "Run", description: "Description10", taskDate: Date(), createdDate: Date(), status: "Progress")
   ]
   
   func add(new task: Task) {
      tasks.append(task)
   }
   
   func tasksCount() -> Int {
      tasks.count
   }
   
   func task(by index: Int) -> Task {
      tasks[index]
   }
   
   func remove(by index: Int) {
      tasks.remove(at: index)
   }
   
   func searche(by title: String) -> [Task] {
      tasks.filter{ task in
         (task.title != nil) ? task.title!.contains(title) : false
      }
   }
   
   func sortByDateNewest() -> [Task] {
      tasks.sorted(by: { $0.createdDate < $1.createdDate })
   }
   
   func sortByDateOldest() -> [Task] {
      tasks.sorted(by: { $0.createdDate > $1.createdDate })
   }
   
   func sortByTaskDateDoneNewest() -> [Task] {
      tasks.sorted(by: { $0.taskDate < $1.taskDate })
   }
   
   func sortByTaskDateDoneOldest() -> [Task] {
      tasks.sorted(by: { $0.taskDate > $1.taskDate })
   }
   
   func sortTitleByAlphabetically() -> [Task] {
      tasks.filter{ task in
         task.title != nil
      }.sorted(by: { $0.title! < $1.title! })
   }
   
   func filterStatus(by status: String) -> [Task] {
      tasks.filter{ task in
         task.status == status
      }
   }
}
