//
//  CaseiterableViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 01/09/25.
//
/*
 Q. 61)  what is caseiterable and write example and syntax?
 Ans.
 
 The CaseIterable protocol allows an enum to provide a collection of all its cases. When an enum conforms to CaseIterable, Swift automatically synthesizes a static property called allCases that contains a collection of all the enum’s cases.
 
 
 */

import UIKit

enum CompassPoint: CaseIterable {
    case north, south, east, west
}

class CaseiterableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(CompassPoint.allCases)
        // Output: [north, south, east, west]

        for direction in CompassPoint.allCases {
            print(direction)
        }

    }
    

}
