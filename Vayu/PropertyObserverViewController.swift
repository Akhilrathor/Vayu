//
//  PropertyObserverViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 24/09/25.
//
/*
 Q. 81) what is property observers?
 Ans.
 
 Property observers are special blocks of code that run automatically when a property’s value is set or changed. They allow us to react to changes in property values without writing extra boilerplate code.

 Swift provides two kinds of observers:

 willSet → Called just before the value is set.

 didSet → Called immediately after the value is set.
 
 
 Q1. What is the difference between willSet and didSet?
 👉 willSet executes before the new value is assigned; didSet executes after assignment.

 Q2. Do property observers work on computed properties?
 👉 No. Computed properties already have get and set logic. Observers are only for stored properties.

 Q3. Are property observers called during initialization?
 👉 No, they are only triggered when the property changes after initialization.

 Q4. When would you use property observers in iOS development?
 👉 Examples: updating UI when a model value changes, syncing data, logging state changes (e.g., isLoading property updating a spinner).
 
 Q. 82) computed property in Swift?
 Ans.
 
 A computed property in Swift does not store a value directly—instead, it calculates a value every time it is accessed via a getter, and optionally allows setting via a setter. Computed properties can be defined in classes, structs, and enums, allowing dynamic calculation of values based on other properties.
 
 Important Points

 * They don’t store values — instead, they compute them dynamically.
 * Read-only computed properties can omit the get keyword.
 * Computed properties can use other properties for calculations.
 
 Interview Q&A

 Q1. Difference between stored and computed property?
 👉 A stored property actually stores a value in memory, while a computed property calculates its value each time it is accessed.

 Q2. Can a computed property have only a getter?
 👉 Yes. That makes it a read-only computed property. Example:

 var perimeter: Double {
     return 2 * (width + height)
 }


 Q3. Do computed properties support property observers (willSet / didSet)?
 👉 No, because computed properties don’t actually store data. Instead, you can add logic inside set.

 Q4. When do you use a computed property in iOS?
 👉 Example: In a User model, instead of storing fullName, we can compute it from firstName + lastName. This avoids redundant storage and keeps data consistent.
 
 Q. 83) what is stored property in Swift?
 Ans.
 
 A stored property in Swift is a variable or constant whose value is stored directly as part of an instance of a class, struct, or enum.It holds actual data (unlike computed properties, which calculate values). Stored properties are the most common type of properties and represent the state of an object.
 
 Important Points

 * Stored properties can be declared with var (mutable) or let (immutable).
 * They can have default values or be set during initialization.
 * Stored properties are available in classes and structs, but not in enums.
 * In classes, stored properties are allocated on the heap; in structs, on the stack (value semantics).
 
 Q. 84) what is Lazy property in Swift?
 Ans
 
 A lazy property in Swift is a stored property whose initial value isn't calculated until the first time it's accessed. Lazy properties are declared using the lazy keyword, making them ideal for expensive or dependent initializations that shouldn't happen during instance creation.
 
 Interview Q&A

 Q1. Why do we use lazy properties?
 👉 To delay costly initialization until the property is actually needed, optimizing memory and performance.

 Q2. Can we declare a lazy property as let? Why/Why not?
 👉 No. Because let requires a value at initialization, while lazy postpones initialization.

 Q3. Are lazy properties thread-safe in Swift?
 👉 No. By default, they are not thread-safe. If accessed from multiple threads simultaneously, initialization can happen multiple times. We need synchronization (e.g., DispatchQueue) if thread safety is required.

 Q4. Give a real-world iOS example where lazy is useful.
 👉 Example: UIImageView with a very large image, or DateFormatter inside a view controller (expensive object, used rarely).

 lazy var formatter: DateFormatter = {
     let f = DateFormatter()
     f.dateStyle = .medium
     return f
 }()
 
 Q. 86) what is kvc is kvo ?
 Ans
 
 KVC (Key-Value Coding) and KVO (Key-Value Observing) are runtime features from the Objective-C Foundation framework, bridged to Swift, enabling dynamic access and observation of object properties using string-based keys (e.g., "name" for a property).
 KVC: A mechanism to access/modify properties indirectly via keys, supporting dot-notation paths (e.g., "user.address.street") and collection operations without knowing the exact type at compile-time.
 KVO: Builds on KVC to automatically notify observers of property changes, allowing reactive programming (e.g., UI updates when data changes).
 
 Interview Q&A

 Q1. What is KVC and where do we use it?
 👉 KVC allows accessing or modifying properties dynamically using string keys. Commonly used in Core Data and dynamic JSON mapping.

 Q2. What is KVO and where do we use it?
 👉 KVO lets one object observe changes to another’s property. Commonly used in bindings, Core Data, and older iOS patterns before Combine/SwiftUI.

 Q3. What’s required to use KVO in Swift?
 👉 The property must be marked @objc dynamic and the class must inherit from NSObject.

 Q4. Difference between KVO and Swift’s property observers (willSet, didSet)?
 👉 - KVO = external objects can observe property changes.
 👉 - Property observers = only the owner object reacts to its own property changes.
 */

import UIKit

class PropertyObserverViewController: UIViewController {
    
    private var ageObservation: NSKeyValueObservation?

    var balance: Double = 0.0 {
        willSet(newBalance) {
            print("Balance will change from \(balance) to \(newBalance)")
        }
        didSet {
            print("Balance changed from \(oldValue) to \(balance)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//         Examples below demonstrate:
//         - Property observers (willSet/didSet) with the 'balance' property: Observe changes and print updates before and after assignment.
        self.balance = 100
        
//        - Computed property with 'Rectangle.area' and 'PersonProperty.isAdult': Calculated dynamically each time accessed.
        let rect = Rectangle(width: 4, height: 5)
        print(rect.area) // Output: 20.0
        
        var p = PersonProperty(name: "Alice", age: 20)
        print(p.name)   // "Alice"  (directly stored)
        print(p.isAdult) // true (computed on demand)
        
//        - Lazy property with 'DataManager.data': Initialized only when accessed the first time, showing deferred and expensive setup.
        let manager = DataManager()
        print(manager.data) // Prints "Loading data..." on first access

        let person = PersonKVC()
        // Using KVC
        person.setValue("Alice", forKey: "name")
        person.setValue(25, forKey: "age")
        print(person.value(forKey: "name")!) // Alice
        print(person.age) // 25
        
        
        // KVO
        let user = ObservableUser()

        ageObservation = user.observe(\ObservableUser.age, options: [.old, .new]) { object, change in
            print("Age changed from \(change.oldValue!) to \(change.newValue!)")
        }

        user.age = 30
    }
    
}

struct Rectangle {
    var width: Double
    var height: Double
    var area: Double {
        return width * height
    }
}

struct PersonProperty {
    // Stored properties
    var name: String
    var age: Int
    
    // Computed property
    var isAdult: Bool {
        return age >= 18
    }
}

class DataManager {
    lazy var data: [String] = {
        print("Loading data...")
        return ["User1", "User2", "User3"]
    }()
}


class PersonKVC: NSObject {
    @objc var name: String = ""
    @objc var age: Int = 0
}

class ObservableUser: NSObject {
    @objc dynamic var age: Int = 0
}
