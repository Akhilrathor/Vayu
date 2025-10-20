//
//  ClosuresViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 22/09/25.
//
/*
 Q. 76) what is closures and types?
 Ans.
 
 A closure in Swift is a self-contained block of code that can capture and store references to variables and constants from its context. Closures can be assigned to variables, passed as parameters, and executed independently; essentially, they are unnamed functions that support functional programming patterns.
 
 Types of Closures in Swift:-
 
 1. Non-Escaping Closures (Default)

 * By default, closures in Swift are non-escaping.

 * This means the closure must complete its execution before the function returns.

 * The closure cannot be stored or executed later outside the function’s lifetime.

 * Commonly used in higher-order functions like map, filter, and reduce, where the closure is executed immediately.
 
 
 2. Escaping Closures (@escaping)

 * An escaping closure is a closure that can outlive the function in which it is passed.

 * It means the closure can be stored and executed later, even after the function has returned.

 * Because of this, Swift forces us to explicitly mark such closures with @escaping.

 * Escaping closures are common in asynchronous programming, such as network requests, completion handlers, and dispatch queues.
 
 3. Autoclosures (@autoclosure)

 * An autoclosure is a closure that is created automatically by wrapping an expression.

 * It does not take any parameters, and it’s executed only when called.

 * The main use case is delayed evaluation or lazy execution, so that a piece of code runs only when it is actually needed.

 * Apple uses autoclosures in functions like assert, precondition, and even in Swift’s || and && operators.

 4. Capturing Closures

 * Closures in Swift can capture and store references to variables and constants from the context in which they are defined.

 * Even if the original scope has gone out of memory, the closure maintains its own copy of those values.

 * This feature is very powerful for maintaining state across multiple calls.
 
 
 5. Global Functions Closures
 
 A global function is the simplest type of closure. It is a named closure that does not capture any values from its surrounding context. Since it exists at the top level of your code, it is essentially a closure with a name.
 
 6. Nested Functions
 
 Functions defined inside other functions; can capture values from their enclosing context.
 
 7. Closure Expressions (Anonymous Closures)
 
 Closure expressions are shortened, inline closure syntax that makes writing closures concise and readable.
 
 8. Trailing Closures
 
 * A syntactic sugar that allows you to write closures outside the parentheses of a function call.

 * Improves readability, especially for closures with long code.
 
 */

import UIKit

class ClosuresViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. Non-escaping closure example
        printMessage {
            print("Non-escaping closure executed ✅")
        }
        
        // 2. Escaping closure example
        fetchData { result in
            print(result)
        }

        // 3. Autoclosure example
        logIfTrue(5 > 2) // expression automatically converted into closure

        // 4. Capturing closure example
        let counter = makeCounter()
        print(counter()) // 1
        print(counter()) // 2
        print(counter()) // 3
        
        // 5. Global function closure example
        let greeting = sayHello(name: "Alice")
        print(greeting) // Prints: "Hello, Alice!"
        
        // 6. Closure expression example
        let numbers = [1, 2, 3]
        let doubled = numbers.map({ $0 * 2 })
        print(doubled) // Output: [2, 4, 6]
        
        // 7. Trailing closure example
        greetUser {
            print("Hello from trailing closure! ✅")
        }

    }
    
    /// Example of a Non-Escaping Closure
    /// The closure parameter is executed immediately within the function and cannot escape its scope.
    func printMessage(action: () -> Void) {
        // action must run inside the function
        action()
    }

    /// Example of an Escaping Closure
    /// The closure parameter can be called after the function returns, so it's marked with @escaping. Common in async operations.
    func fetchData(completion: @escaping (String) -> Void) {
        // completion will run later, not immediately
        DispatchQueue.global().async {
            completion("Data received ✅")
        }
    }

    /// Example of an Autoclosure
    /// The closure is created automatically to delay evaluation of the condition until it's actually needed.
    func logIfTrue(_ condition: @autoclosure () -> Bool) {
        if condition() {
            print("Condition is true ✅")
        }
    }
    
    /// Example of a Capturing Closure
    /// Returns a closure that captures and maintains its own state (the 'count' variable) across multiple calls.
    func makeCounter() -> () -> Int {
        var count = 0
        return {
            count += 1
            return count
        }
    }

    // A named global function
    func sayHello(name: String) -> String {
        return "Hello, \(name)!"
    }

    //Example of a Trailing closure
    func greetUser(action: () -> Void) {
        action()
    }

}
