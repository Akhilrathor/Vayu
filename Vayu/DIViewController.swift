//
//  DIViewController.swift
//  InterviewPrep
//
//  Created by Akhilesh Rathor on 7/21/25.
//
/*
 32) what is dependency injection and dependency inversion?
 Ans.
 
 Dependency Injection is a software design pattern that focuses on providing the dependencies of a component from the outside, rather than letting the component create its own dependencies. The primary goal is to decouple components and make the codebase more modular, scalable, and easy to test.
 There are several ways to implement DI in Swift:
 
 1. Constructor Injection: This is the most common method where dependencies are passed through the initializer.
 
 2. Property Injection: Dependencies can also be set via properties after the object is created.
 
 3. Method Injection: Dependencies can be passed as parameters to methods.
 
 Dependency Inversion:
 
 The Dependency Inversion Principle is one of the SOLID principles in object-oriented programming. It states:

 High-level modules should not depend on low-level modules; both should depend on abstractions (e.g., protocols or interfaces).

 Abstractions should not depend on details; details (the actual implementation) should depend on abstractions.
 
 
 
 */

import UIKit

class DIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Constructor Injection Example
        let mySQLDatabase = MySQLDatabase()
        let userService = UserService(database: mySQLDatabase)
        userService.performAction()
        
        // Property Injection Example
        let userService2 = UserService2()
        userService2.database = MySQLDatabase()
        userService2.performAction()
        
        // Method Injection Example
        let userService3 = UserService3()
        userService3.performAction(with: MySQLDatabase())
        
        // Dependency Inversion Principle (DIP) Example
        let realService = APIService()
        let viewModel = ViewModel2(service: realService)
        viewModel.load() // Output: Fetching from API

    }

}

protocol Database {
    func connect()
}

class MySQLDatabase: Database {
    func connect() {
        print("Connecting to MySQL")
    }
}

class UserService {
    private let database: Database

    init(database: Database) {
        self.database = database
    }

    func performAction() {
        database.connect()
    }
}

class UserService2 {
    var database: Database?

    func performAction() {
        database?.connect()
    }
}


class UserService3 {
    func performAction(with database: Database) {
        database.connect()
    }
}


// Dependency Inversion Principle (DIP) Example
// Abstraction
protocol NetworkService {
    func fetchData()
}

// Low-level module
class APIService: NetworkService {
    func fetchData() {
        print("Fetching from API")
    }
}

// High-level module
class ViewModel2 {
    private let service: NetworkService // depending on protocol

    init(service: NetworkService) {
        self.service = service
    }

    func load() {
        service.fetchData()
    }
}

