//
//  ViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 28/06/25.
//

import UIKit
/*24) What is init() in Swift? And its types?

 Ans.

 init() refers to an initializer.
An initializer is a special method used to prepare a new instance of a class, structure, or enumeration for use. It's essentially the process of setting an initial value for each stored property and performing any necessary setup before the instance is ready.

There are several ways to initialise instances of classes, structures, enums and actors:-

1. Designated Initializers
2. Convenience Initializers
3. Failable Initializers
4. Required Initializers
5. Default Initializers
6. Memberwise Initializers (for Structures)
7. Lazy Initializers

1. Designated Initializers:-

Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.

Example:
*/
class Initializers: UIViewController {
    
    override func viewDidLoad() {
            super.viewDidLoad()
        var person = Person(name: "Ashoo")
        var employee = Employee(name: "Akhil") //It will give you the error and will ask you to add missing param(name)
    }
}

//Initial there will be the default initializers in class and structure both
class Person {
    var name: String //In this way for the class will give the error it will either ask you to add default property (var name: String = "") or will ask you to override the init method like this :
    var country: String
    
// Either it can implement like this with hardcode assign a country name
    init(name: String) {
        self.name = name
        self.country = "India"
    }
//OR like this:
    init(name: String, country: String) {
        self.name = name
         self.country = country
    }
}

struct Employee {
    var name: String
    }
         
/*
* So, Designated initializers are defaultly present in structures but not in the class
* Class can have multiple designated initializers
*/
