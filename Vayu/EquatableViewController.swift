//
//  EquatableViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 11/30/25.
//
/*
 Q. 91) equitable and hashbal and comparable protocols?
 
 Ans. In Swift, the Equatable, Hashable, and Comparable protocols are core standard-library protocols that enable custom types to be compared, sorted, or stored efficiently in collections.
 
 #Equatable: The Equatable protocol defines a way to compare two instances of the same type for equality.
             Use when you need to determine if two instances are the same — such as comparing users, scores, or states.
 
 #Hashable: Hashable allows a type to provide a unique hash value, enabling objects to be used efficiently in Set or Dictionary collections. Used when objects need unique identifiers within collections, e.g., dictionary keys or sets.
 
 #Comparable: The Comparable protocol is used to order instances of a type using relational comparison operators, such as less than (<), greater than (>), less than or equal to (<=), and greater than or equal to (>=).
 
 */

import UIKit

class EquatableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let emp1 = EmployeeEquat(id: 101, name: "Akhilesh")
        let emp2 = EmployeeEquat(id: 102, name: "Rathor")

        print(emp1 == emp2) // false (Equatable)
        print(Set([emp1, emp2])) // Works because of Hashable
        print([emp1, emp2].sorted()) // Works because of Comparable
    }

}

struct EmployeeEquat: Equatable, Hashable, Comparable {
    
    let id: Int
    let name: String

    // MARK: - Equatable
    static func == (lhs: EmployeeEquat, rhs: EmployeeEquat) -> Bool {
        lhs.id == rhs.id
    }

    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }

    // MARK: - Comparable
    static func < (lhs: EmployeeEquat, rhs: EmployeeEquat) -> Bool {
        lhs.id < rhs.id
    }
}

