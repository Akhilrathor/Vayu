//
//  SyncAsyncViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 24/07/25.
//
/*
 #40) What is asynchronous Vs synchronous?
 Ans.

 Synchronous and asynchronous are two fundamental programming models that describe how tasks are executed, waited for, and completed within an application.

 ##Synchronous

 **Execution:** Tasks are performed sequentially—each operation starts only after the previous one finishes.

 **Blocking:** The program waits (blocks) for each operation to complete before moving on.

 **Simplicity:** Easier to read, debug, and predict due to its linear flow.

 **Use Cases:** Best for tasks that need strict order or are quick to complete, e.g., core calculations, simple scripts.

 **Example:**
 Reading a file and then processing its contents—processing cannot begin until reading finishes.

 ##Asynchronous

 **Execution:** Tasks are performed concurrently—multiple operations can start before others finish.

 **Non-blocking:** The program does not wait for a task to complete before starting the next one.

 **Performance:** Enables better throughput, responsiveness, and scalability, especially for I/O-bound work like network or disk access.

 **Complexity:** Code can be harder to follow and debug due to non-linear execution.

 **Use Cases:** Ideal for tasks where waiting wastes time (network requests, file/input-output).

 **Example:**
 Sending a network request and allowing the user interface to remain responsive while waiting for the response.
 */

import UIKit

class SyncAsyncViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Synchronous Example

        print("Start fetching data...")
        let data = fetchData() // This will block until fetchData() is complete
        print(data) // Output: Data fetched
        print("Done fetching data.")
        
        //Asynchronous Example
        
        print("Start fetching data...")
        fetchDataAsync { data in
            print(data) // This will be printed after 2 seconds
        }
        print("Done fetching data.")
        
    }
    //Synchronous Example
    func fetchData() -> String {
        // Simulate a time-consuming task
        sleep(2) // Sleep for 2 seconds
        return "Data fetched"
    }
    
    //Asynchronous Example
    func fetchDataAsync(completion: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            // Simulate a time-consuming task
            sleep(2) // Sleep for 2 seconds
            completion("Data fetched")
        }
    }

}

