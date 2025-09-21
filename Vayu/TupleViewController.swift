//
//  TupleViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 01/09/25.
//
/*
 Q. 62) what is tuple?
 Ans.
 
 A tuple is a lightweight, ordered group of multiple values combined into a single compound value. Each value in a tuple can be of any type, and the types can be different from each other.
 
 
 
 */

import UIKit

class TupleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Example 1 – Simple Tuple
        let person = ("Akhilesh", 28)
        print(person.0)  // Akhilesh
        print(person.1)  // 28
        
        //Example 2 – Named Tuple
        let person2 = (name: "Akhilesh", age: 28)
        print(person2.name)  // Akhilesh
        print(person2.age)   // 28


    }

}
