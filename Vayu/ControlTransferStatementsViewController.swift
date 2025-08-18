//
//  ControlTransferStatementsViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 13/07/25.
//

/*
 Q. 28) What are Control Transfer Statements in Swift?
 Ans.
 
 Control transfer statements in Swift are used to change the flow of execution from one part of your code to another.
 
 🔹 Types of Control Transfer Statements in Swift:
 
 | Statement     | Use Case                                                                |
 | ------------- | -------------------------------------------------------------------     |
 | `break`       | Exits the nearest enclosing loop or switch statement immediately and                     transfers control after it.                                             |
 | `continue`    | Skips the current iteration of a loop and moves to the next iteration.  |
 | `fallthrough` | Move to the next case in a switch (even if the current one matched)     |
 | `return`      | Exit from a function/method and optionally return a value               |
 | `throw`       | Transfer control by throwing an error                                   |

    
 */
import UIKit

class ControlTransferStatementsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        1️⃣ break
        for i in 1...5 {
            if i == 3 {
                break // Exit the loop when i is 3
            }
            print(i)
        }
        // Output: 1 2

//        2️⃣ continue
        for i in 1...5 {
            if i == 3 {
                continue // Skip printing 3
            }
            print(i)
        }
        // Output: 1 2 4 5

//        3️⃣ fallthrough (used in switch)
        let number = 1
        switch number {
        case 1:
            print("One")
            fallthrough
        case 2:
            print("Two")
        default:
            print("zero")
        }
        // Output: One Two
        
        //    4️⃣ return
       print( greet(name: "Akhil"))
        
        //    5️⃣ throw
        performLogin()
    }
    
//    4️⃣ return
    func greet(name: String) -> String {
        return "Hello, \(name)"
    }
    
    enum LoginError: Error {
        case wrongPassword
    }

    func login(password: String) throws {
        if password != "1234" {
            throw LoginError.wrongPassword
        }
    }
    
    // Calling it
    func performLogin() {
        do {
//            try login(password: "1234") // ✅ correct password
             try login(password: "0000") // ❌ wrong password
        } catch LoginError.wrongPassword {
            print("Incorrect password.")
        } catch {
            print("Some other error: \(error)")
        }
    }


}
