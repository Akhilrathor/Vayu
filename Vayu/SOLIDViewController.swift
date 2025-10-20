//
//  SOLIDViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 24/09/25.
//
/*
 Q. 87) what is solid principle?
 Ans.
 
 SOLID is an acronym for five key object-oriented design principles introduced by Robert C. Martin (Uncle Bob), aimed at making software designs more understandable, flexible, scalable, and maintainable.
 
 Here is a summary of each principle:

 1. Single Responsibility Principle (SRP)
 * A class should have only one reason to change, meaning it has only one job or responsibility.

 * Benefits: Easier testing, reduced complexity, better maintainability.

 * Example: Separate Report generation and Report printing into separate classes.

 2. Open-Closed Principle (OCP)
 * Software entities (classes, modules, functions) should be open for extension but closed for modification.

 * Benefits: Allows new features to be added without changing existing code, reducing risk of bugs.

 * Example: Extend Invoice class functionality using subclasses without modifying it.

 3. Liskov Substitution Principle (LSP)
 * Objects of a superclass should be replaceable with objects of a subclass without altering the correctness of the program.

 * Ensures inheritance is used properly and subclasses behave as expected.

 4. Interface Segregation Principle (ISP)
 * Clients should not be forced to depend on interfaces they do not use.

 * Encourage creating small, specific interfaces rather than large general ones.

 * Benefits: Reduced side effects and improved modularity.

 5. Dependency Inversion Principle (DIP)
 * High-level modules should not depend on low-level modules; both should depend on abstractions.

 * Abstractions should not depend on details; details should depend on abstractions.

 * Promotes loose coupling and easier testing.
 
 Interview Q&A

 Q. What does SOLID stand for?
 Single Responsibility, Open-Closed, Liskov Substitution, Interface Segregation, Dependency Inversion.

 Q. Why are SOLID principles important?
 They reduce dependencies, improve code maintainability and scalability, and prevent "software rot."

 Q. How does the Single Responsibility Principle help in design?
 By ensuring each class or module solves one problem, reducing complexity and making testing easier.

 Q. What is the essence of the Dependency Inversion Principle?
 Code should depend on abstractions (interfaces), not on concrete implementations, promoting loose coupling.
 
 */

import UIKit

class SOLIDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 👉 Validation and saving are separate concerns.
        let validator = UserValidator()
        let manager = UserDataManager()

        let user = "Alice"
        if validator.isValid(user: user) {
            manager.save(user: user)
        }
        
        // 👉 Adding ApplePayPayment won’t break existing code.
        func makePayment(using method: Payment) {
            method.process()
        }

        makePayment(using: CreditCardPayment())
        makePayment(using: UpiPayment())
        
        // 👉 If we add a Penguin subclass that can’t fly, it would violate LSP.
        let birds: [Bird] = [Sparrow(), Crow()]
        for b in birds {
            b.fly() // Works fine for all birds
        }
        
        // 👉 Clients use only what they need.
        let hpPrinter = SimplePrinter()
        hpPrinter.printDocument()

        let canonAllInOne = AllInOneMachine()
        canonAllInOne.printDocument()
        canonAllInOne.scanDocument()

        // 👉 UserService is decoupled from specific database implementations.
        let mySQLService = DIPUserService(db: DIPMySQLDatabase())
        mySQLService.saveUser()   // Saving data to MySQL

        let mongoService = DIPUserService(db: MongoDBDatabase())
        mongoService.saveUser()   // Saving data to MongoDB
    }

}


// One class for saving
class UserDataManager {
    func save(user: String) {
        print("Saving \(user) to DB")
    }
}

// Another class for validation
class UserValidator {
    func isValid(user: String) -> Bool {
        return !user.isEmpty
    }
}

protocol Payment {
    func process()
}

class CreditCardPayment: Payment {
    func process() { print("Paid with Credit Card") }
}

class UpiPayment: Payment {
    func process() { print("Paid with UPI") }
}


class Bird {
    func fly() {
        print("Bird is flying")
    }
}

class Sparrow: Bird {}

class Crow: Bird {}


protocol Printer {
    func printDocument()
}

protocol Scanner {
    func scanDocument()
}

class SimplePrinter: Printer {
    func printDocument() { print("Printing...") }
}

class AllInOneMachine: Printer, Scanner {
    func printDocument() { print("Printing...") }
    func scanDocument() { print("Scanning...") }
}


protocol DIPDatabase {
    func saveData()
}

class DIPMySQLDatabase: DIPDatabase {
    func saveData() { print("Saving data to MySQL") }
}

class MongoDBDatabase: DIPDatabase {
    func saveData() { print("Saving data to MongoDB") }
}

class DIPUserService {
    private let db: DIPDatabase
    init(db: DIPDatabase) {
        self.db = db
    }
    func saveUser() {
        db.saveData()
    }
}
