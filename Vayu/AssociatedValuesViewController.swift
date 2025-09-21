//
//  AssociatedValuesViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 31/08/25.
//
/*
Q. 60) what is associated values in ios Swift?

Ans. Associated values in Swift are additional pieces of data that can be stored alongside a particular case of an enumeration (enum). Unlike raw values, which are fixed constants, associated values allow you to attach custom, dynamic data to each enum case when you create an instance of that case.
 
 */
import UIKit

enum Distance {
    case km(Double)
    case miles(Double)
}

class AssociatedValuesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let d1 = Distance.km(5.0)
        let d2 = Distance.miles(3.1)

        printDistance(d1)   // Distance in kilometers: 5.0
        printDistance(d2)   // Distance in miles: 3.1

    }
    
    func printDistance(_ distance: Distance) {
        switch distance {
        case .km(let value):
            print("Distance in kilometers: \(value)")
        case .miles(let value):
            print("Distance in miles: \(value)")
        }
    }

}
