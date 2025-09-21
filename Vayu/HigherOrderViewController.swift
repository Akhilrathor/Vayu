//
//  HigherOrderViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 27/08/25.
//
/*
 Q. 59) what is higher order function and also ask programs on this and difference in(map, compactmap, flatmap)?
 Ans.
 
 A higher-order function is a function that can take other functions as parameters or return a function as its result. In Swift, higher-order functions are commonly used with collections, allowing for more expressive and concise code. They enable functional programming paradigms, such as mapping, filtering, and reducing collections.
 
 1. Map: Transforms each element in a collection using a provided closure and returns a new collection containing the transformed elements.
 
 2. CompactMap: Similar to map, but it also removes any nil values from the resulting collection.
 
 3. FlatMap: Flattens a collection of collections into a single collection. It can also be used to transform elements and flatten the result.
 
 4. Filter: Returns a new collection of the same type containing, in order, the elements of the original collection that satisfy the given predicate.
 
 5. Reduce: reduce is a higher-order function that combines all elements of a collection into one single value using a closure. It takes two things:
    a) Initial value (starting point)
    b) Closure (that tells how to combine elements)
 
 6. ForEach: The forEach function is a higher-order function that executes a given closure on each element of a collection. Unlike map or reduce, it does not return a new collection or a value; it simply performs side effects, such as printing or modifying external state.
 
 7. Sorted: sorted is a higher-order function that returns a new array containing the elements of the original collection, arranged in ascending order by default or according to a custom predicate provided.
 
 8. Contains: The contains function checks whether a collection contains a specific element or satisfies a given condition. It returns a Boolean value (true or false).
 
 9. Sort: sort() is an in-place sorting method that rearranges the elements of an array according to the specified order (ascending by default). Unlike sorted(), it does not return a new array but modifies the original array directly.
 
 */

import UIKit

class HigherOrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. Map Example
        let numbers = [1, 2, 3, 4, 5]
        let squaredNumbers = numbers.map { $0 * $0 }
        print(squaredNumbers) // Output: [1, 4, 9, 16, 25]
        
        // 2. CompactMap Example
        let mixedArray: [String?] = ["1", "2", nil, "4", "five"]
        let nums = mixedArray.compactMap { Int($0 ?? "") }
        print(nums) // Output: [1, 2, 4]
        
        //3. FlatMap Example
        let nestedArray = [[1, 2], [3, 4], [5]]
        let flattenedArray = nestedArray.flatMap { $0 }
        print(flattenedArray) // Output: [1, 2, 3, 4, 5]
        
        //4. Filter Example
        let filterNum = [1, 2, 3, 4, 5]
         let evenNumbers = filterNum.filter { $0 % 2 == 0 }
         print(evenNumbers) // Output: [2, 4]
        
        //5. Reduce Example
        let reduceNum = [1, 2, 3, 4, 5]
        let sum = reduceNum.reduce(0) { $0 + $1 }
        print(sum) // Output: 15
        
        //6. ForEach Example
        let forEachNum = [1, 2, 3, 4, 5]
        forEachNum.forEach { print($0) }
        // Output: 1
        //         2
        //         3
        //         4
        //         5
        
        //7. Sorted Example
        let unSortedNum = [5, 3, 1, 4, 2]
        let sortedNumbers = unSortedNum.sorted()
        print(sortedNumbers) // Output: [1, 2, 3, 4, 5]
        
        //8. Contains Example
        let containsNum = [1, 2, 3, 4, 5]
        let hasThree = containsNum.contains(3)
        print(hasThree) // Output: true
        
        //9. Sort Example
        var words = ["apple", "banana", "fig"]
        words.sort { $0.count < $1.count }
        print(words)  // Output: ["fig", "apple", "banana"]
    }
}
