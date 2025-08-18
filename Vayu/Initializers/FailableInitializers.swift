//
//  FailableInitializers.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 28/06/25.
//
/*
 3. Failable Initializers:-
 
 It’s sometimes useful to define a class, structure, or enumeration for which initialization can fail. This failure might be triggered by invalid initialization parameter values, the absence of a required external resource, or some other condition that prevents initialization from succeeding.
 
 In simple terms, a failable initializer is used when you don’t always want to create and return an object. It allows you to perform some kind of pre-check, and if that check fails, the initializer returns nil instead of creating an instance.

 We use failable initializers in cases where object creation can fail due to invalid input or conditions that don't meet required criteria.
 */

import UIKit

class FailableInitializers: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        var person = Person2(name: "Ashoo", country: "India")
        var person1 = Person3(name: "Ashoo")
        print(person1)
        var person2 = Person3(name: "")
        print(person2)
    }
    
    

    
}

class Person3 {
    var name: String
    var country: String
    
    init?(name: String, country: String) {
        if name.isEmpty{
            return nil
        }
        self.name = name
        self.country = country
    }
    
    convenience init?(name: String) {
        self.init(name: name, country: "India")
    }
}

struct Employee3 {
    var name: String
}
