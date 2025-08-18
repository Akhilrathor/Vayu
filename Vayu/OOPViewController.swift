//
//  OOPViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 20/07/25.
//
/*
 31) what is OOPS?
 Ans.
 
 Object-Oriented Programming (OOP) in Swift is a core programming paradigm used for iOS app development. OOP organizes code by modeling real-world entities as objects that encapsulate both data (properties) and behavior (methods). Swift fully supports OOP, and most Apple frameworks use this paradigm as their foundation.
 
 Here are the key OOP concepts in Swift for iOS development:-
 
 1.Classes and Objects:
   Class: A blueprint for creating objects. It defines properties (attributes) and methods (functions) that the objects created from the class can use.
   Object: An instance of a class. Each object can have its own state and behavior defined by the class.
 
2.Encapsulation:
 Encapsulation is the bundling of data (properties) and methods that operate on that data within a single unit (class). It restricts direct access to some of the object's components, which is a means of preventing unintended interference and misuse.
 In Swift, you can use access control keywords like private, fileprivate, internal, and public to control access to properties and methods.
 
 3. Polymorphism:
    Polymorphism means "many forms". It allows a unified interface for different data types, making it possible for one method or property to behave differently for different classes. This is achieved through method overloading at compile time, and method overriding at runtime, enabling one interface to be used for a general class of actions.
 
   Polymorphism in programming can be categorized into two types: Compile-time polymorphism and Runtime polymorphism.
 
   (1) Compile-time Polymorphism:-
 
   Definition: Compile-time polymorphism, also known as static polymorphism, occurs when the method to be executed is determined at compile time. This is typically achieved through method overloading or operator overloading.
 
   (2) Runtime Polymorphism:-
 
   Definition: Runtime polymorphism, also known as dynamic polymorphism, occurs when the method to be executed is determined at runtime. This is typically achieved through method overriding in inheritance.
 
 
 4. Inheritance:
 Inheritance allows one class (subclass) to inherit properties and methods from another class (superclass), enabling code reuse.
 
 5. Abstraction:
 
 Abstraction is the concept of hiding complex implementation details and exposing only the necessary information or functionality to the user. This allows for a simplified interface, making code more understandable and manageable. Swift achieves abstraction primarily through protocols, which define a blueprint of methods and properties that conforming types must implement, and opaque types, which hide the specific type while still allowing for dynamic dispatch.

 
 
 
 */

import UIKit

class OOPViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Class & Object Example
        let myCar = Car(color: "Red", model: "Toyota")
        myCar.drive() // Output: Driving a Red Toyota
        
        //2. Encapsulation Example
        let account = BankAccount()
        account.deposit(amount: 100)
        print(account.getBalance())
        
        //3. Polymorphism Example
        let animals: [Animal] = [Dog(), Cat()]
        for animal in animals {
            animal.makeSound() // Output: Bark, Meow
        }
        
        //4. Inheritance Example
        let car2 = Car2()
        car2.startEngine()  // Inherited
        car2.drive()
        
        //3.(1) Compile-time Polymorphism
        let math = MathOperations()
        print(math.add(a: 5, b: 10))         // Output: 15 (Int addition)
        print(math.add(a: 5.5, b: 10.5))     // Output: 16.0 (Double addition)
        print(math.add(a: 5, b: 10, c: 15))  // Output: 30 (Three Ints addition)
        
        //3.(2) Run-time Polymorphism
        let myDog = Dog2()
        let myCat = Cat2()

        playSound(animal: myDog) // Output: Bark
        playSound(animal: myCat) // Output: Meow
        
        
        //5. Abstraction Example
        let circle = Circle()
        let square = Square()
        renderShape(circle) // Output: Drawing a circle.
        renderShape(square) // Output: Drawing a square.
    }

}

//1. Class and Object Example
class Car {
    var color: String
    var model: String

    init(color: String, model: String) {
        self.color = color
        self.model = model
    }

    func drive() {
        print("Driving a \(color) \(model)")
    }
}

//2. Encapsulation Example
class BankAccount {
    private var balance: Double = 0  // Encapsulated
    
    func deposit(amount: Double) {
        balance += amount
    }
    
    func getBalance() -> Double {
        return balance
    }
}

//3. Polymorphism Example
class Animal {
    func makeSound() {
        print("Some sound")
    }
}

class Dog: Animal {
    override func makeSound() {
        print("Bark")
    }
}

class Cat: Animal {
    override func makeSound() {
        print("Meow")
    }
}

//4. Inheritance Example
class Vehicle {
    func startEngine() {
        print("Engine started")
    }
}

class Car2: Vehicle {
    func drive() {
        print("Car is driving")
    }
}

// 3.(1) Example of Compile-time Polymorphism(Method Overloading):

class MathOperations {
    // Method to add two integers
    func add(a: Int, b: Int) -> Int {
        return a + b
    }
    
    // Method to add two doubles
    func add(a: Double, b: Double) -> Double {
        return a + b
    }
    
    // Method to add three integers
    func add(a: Int, b: Int, c: Int) -> Int {
        return a + b + c
    }
}


//3.(2) Example of Run-time Polymorphism(Method Overriding:)
class Animal2 {
    func makeSound() {
        print("Some generic animal sound")
    }
}

class Dog2: Animal2 {
    override func makeSound() {
        print("Bark")
    }
}

class Cat2: Animal2 {
    override func makeSound() {
        print("Meow")
    }
}

func playSound(animal: Animal2) {
    animal.makeSound() // The actual method called is determined at runtime
}


//5. Abstraction Example
protocol Drawable {
    func draw()
}

class Circle: Drawable {
    func draw() {
        print("Drawing a circle.")
    }
}

class Square: Drawable {
    func draw() {
        print("Drawing a square.")
    }
}

func renderShape(_ shape: Drawable) {
    shape.draw()
}

