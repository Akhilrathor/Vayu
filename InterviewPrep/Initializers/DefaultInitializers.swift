//
//  DefaultInitializers.swift
//  InterviewPrep
//
//  Created by Akhilesh Rathor on 30/06/25.
//
/*
 5. Default Initializers:-
 
 Default initializers are those initializers that are automatically created by the Swift compiler when a class or structure does not contain any customised initialiser or all the properties have default values. They are used to create instances of a class or structure with all its properties set to their default values.
 */


import UIKit

class DefaultInitializers: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Creating an instance with default initializer
        let result = defaultexample()
        // Accessing properties
        print("result is: \(result.stmark)")
        print("result is: \(result.pass)")
    }
    

}

class defaultexample {

   // Properties with default value
   var stmark = 98
   var pass = true
}
