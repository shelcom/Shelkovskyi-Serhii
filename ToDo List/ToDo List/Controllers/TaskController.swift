//
//  TaskController.swift
//  ToDo List
//
//  Created by Serhii on 05.11.2021.
//

import Foundation

class TaskController {
   
   let defaults = UserDefaults.standard
   
   private var tasks: [Task] {
      get {
         if let data = defaults.value(forKey: "tasks") as? Data {
            return try! PropertyListDecoder().decode([Task].self, from: data)
         } else {
            return [Task]()
         }
      }
      set {
         guard let data = try? PropertyListEncoder().encode(newValue) else { return }
         defaults.set(data, forKey: "tasks")
      }
   }
   
   func add(name: String, description: String, taskDate: Date) -> Task {
      let newTask = Task.init(title: name, description: description, taskDate: taskDate, createdDate: Date(), status: "Done")
      tasks.append(newTask)
      return newTask
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
