//
//  TaskViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 19/07/25.
//
/*
 29) What is Task in Swift?
 Ans.
 
 Task in Swift is used to create and run asynchronous code in Swift’s structured concurrency model, introduced in Swift 5.5 with async/await. It allows you to start async operations like network calls or background work without blocking the main thread.
 
 
 🔹 Types of Task
 | Type               | Usage                           |
 | ------------------ | ------------------------------- |
 | `Task {}`          | Start a new concurrent task     |
 | `Task.detached {}` | Run without parent task context |
 | `Task.sleep`       | Suspend a task for some time    |
 | `Task.cancel()`    | Cancel a task manually          |
 
 
 
 Task.detached {}
 
 Task.detached is used to create a completely independent async task, not inheriting the parent task’s priority, actor, or context.
 
 */

import UIKit

class TaskViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("Start async task")
        
        Task {
            let message = await fetchData()
            print("Message from async task: \(message)")
        }
        
        Task.detached {
            let isMain = Thread.isMainThread
            print("Detached task running on main thread? \(isMain)") // ❌ usually false (runs in background)

            let data = await self.loadHeavyData()
            print("Data: \(data)")
        }

    }
    
    func fetchData() async -> String {
        try? await Task.sleep(nanoseconds: 2_000_000_000) // Simulate 2s delay
        return "Data loaded"
    }
    
    func loadHeavyData() async -> String {
        // Simulate delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return "Heavy data loaded"
    }
}

//class TaskViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        print("Start parallel data fetches...")
//
//        // Independent task
//        Task.detached {
//            let data1 = await self.fetchPrimaryData()
//            print("Primary Data: \(data1)")
//        }
//
//        // Another independent task
//        Task.detached {
//            let data2 = await self.fetchSecondaryData()
//            print("Secondary Data: \(data2)")
//        }
//    }
//
//    func fetchPrimaryData() async -> String {
//        try? await Task.sleep(nanoseconds: 2_000_000_000)
//        return "Primary data loaded"
//    }
//
//    func fetchSecondaryData() async -> String {
//        try? await Task.sleep(nanoseconds: 1_000_000_000)
//        return "Secondary data loaded"
//    }
//}
