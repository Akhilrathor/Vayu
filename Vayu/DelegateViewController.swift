//
//  DelegateViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 9/23/25.
//
/*
 Q. 75) what is delegate?
 Ans

 A delegate in iOS is a design pattern that enables one object to delegate responsibility for specific tasks or events to another object, establishing a one-to-one communication contract. This separation is commonly achieved using protocols, which define the methods the delegate must implement. The delegate pattern promotes loose coupling between objects, improves code modularity, and makes code easier to extend and maintain.
 
 Follow-Up/Related Interview Questions

 1. Why use a weak reference for delegates?

 To avoid retain cycles since both the delegating object and delegate could strongly reference each other, leading to memory leaks.

 2. How does the delegate pattern differ from the observer pattern?

 The delegate pattern is a one-to-one communication model using protocols for specific interactions, while the observer pattern (e.g., using NotificationCenter) is one-to-many, allowing multiple observers to respond to events.

 3. Can delegates be used with structs?

 Delegate properties must be classes (reference types), not structs (value types), because delegates typically require weak references and protocol conformance limitations apply to structs.

 4. What are some typical pitfalls or best practices when implementing delegates?

 Always declare the delegate as weak to avoid retain cycles, and prefer protocols that can be adopted by classes. Keep the delegate protocol focused and avoid adding too many responsibilities.

 5. Give a system example of a delegate in iOS SDK.

 UITableView uses UITableViewDelegate and UITableViewDataSource protocols. The view controller acts as the delegate, handling tasks like cell selection and editing operations.
 
 */
import UIKit

// Step 1: Define the protocol
protocol DownloadManagerDelegate: AnyObject {
    func downloadManager(_ manager: DownloadManager, didFinishDownloading data: Data)
}

// Step 2: Create delegator
class DownloadManager {
    weak var delegate: DownloadManagerDelegate?   // Weak to avoid retain cycles
    
    func startDownload() {
        // Simulate async download
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let fakeData = Data("Hello".utf8)
            DispatchQueue.main.async {
                self.delegate?.downloadManager(self, didFinishDownloading: fakeData)
            }
        }
    }
}

// Step 3: Adopt the protocol
class DelegateViewController: UIViewController, DownloadManagerDelegate {
    let manager = DownloadManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.startDownload()
    }

    func downloadManager(_ manager: DownloadManager, didFinishDownloading data: Data) {
        print("Download complete: \(data)")
    }
}

