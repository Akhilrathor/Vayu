//
//  SingletonViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 24/08/25.
//
/*
 Q.56) what is singleton design pattern and syntax and example?
 Q.57) how to reallocate and deallocation memory in singleton pattern? (Cross question low priority)
 Ans.
 
 The singleton design pattern is a creational pattern that ensures a class has only one instance during the lifetime of an application and provides a global, shared point of access to that instance. It's commonly used for shared resources like loggers, app settings, network managers etc.
 
 Pattern Components:-

 * Private initializer: Prevents other parts of the code from creating instances.

 * Static (shared) property: Holds the single allowed instance and provides global access.

 * Class (or struct – less common): The pattern is most often used with classes.
 
 
 By default, a Singleton in Swift lives for the entire lifecycle of the app, because it’s usually created as a static constant. That means it doesn’t deallocate automatically.

 If you want to control allocation and deallocation:

 Don’t use static let. Instead, use a static variable with optional type, so you can set it to nil when not needed.

 This way, ARC (Automatic Reference Counting) will deallocate the instance when you remove all references.
 
 */

import UIKit

class SingletonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Usage
        let manager = NetworkManager.shared
        manager?.fetchData()
        
        // Deallocate
        NetworkManager.shared = nil   // ARC releases memory here
        // Accessing the Singleton instance
        MySingleton.shared.doSomething()
    }
    
}

class NetworkManager {
//    static let shared = NetworkManager()  // global instance
    
    static var shared:NetworkManager? = NetworkManager() //Use a static variable with optional type, so you can set it to nil for deallocation
    private init() {}  // prevents external instantiation
    
    func fetchData() {
        print("Fetching data from server...")
    }
}

class MySingleton {
    // 1. Static property to hold the single instance
    static let shared = MySingleton()

    // 2. Private initializer to prevent external instantiation
    private init() {
        // Initialization code (e.g., loading configuration, setting up a logger)
        print("MySingleton instance initialized.")
    }

    // Example method
    func doSomething() {
        print("MySingleton is doing something.")
    }
}
