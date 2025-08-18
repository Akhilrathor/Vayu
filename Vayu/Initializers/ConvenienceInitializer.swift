//
//  ConvenienceInitializer.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 28/06/25.
//
/*
2. Convenience Initializers:-

Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type.

 */
import UIKit

class ConvenienceInitializer: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        var person = Person2(name: "Ashoo", country: "India")
        var person2 = Person2(name: "Ashoo")// Using the convenience initializer, we only need to pass the name. The country is set to a default or hardcoded value internally.
        var employee = Employee2(name: "Akhil")
    }
    
    

    
}

class Person2 {
    var name: String
    var country: String
    
    init(name: String, country: String) {
        self.name = name
        self.country = country
    }
    
    convenience init(name: String) {
        self.init(name: name, country: "India")
    }
    // A convenience initializer must call a designated initializer from the same class.
    // If the designated initializer above is not defined, this convenience initializer will result in a compile-time error.
}

struct Employee2 {
    var name: String
}
