//
//  CollectionViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 01/09/25.
//
/*
 Q. 63) collection types in Swift?
 Ans.
 
 Swift provides three primary collection types to store multiple values in an organized way:
 
 1) Array:
 * An ordered collection of values.
 * Elements are stored in the order you add them.
 * Elements can be accessed by their index (starting at 0).
 * Arrays can hold values of any type, but all elements must be of the same type.
 
 2) Set:
 * An unordered collection of unique values.
 * No duplicates allowed.
 * Useful when the order doesn’t matter but uniqueness does.
 * Elements must conform to the Hashable protocol.
 
 3) Dictionary:
 A collection of key-value pairs.
 * Keys are unique and used to access corresponding values.
 * Keys must conform to the Hashable protocol.
 * Values can be of any type.
 
 */

import UIKit

class CollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //1) Array Example
        var numbers: [Int] = [1, 2, 3, 4, 5]
        print(numbers[0]) // Output: 1
        
        //2) Set Example
        var uniqueNumbers: Set<Int> = [1, 2, 3, 3, 4]
        print(uniqueNumbers) // Output: [2, 4, 1, 3] (order may vary)
        
        //3) Dictionary Example
        var studentGrades: [String: Int] = ["Alice": 90, "Bob": 85]
        print(studentGrades["Alice"]!) // Output: 90
        
        
    }

}
