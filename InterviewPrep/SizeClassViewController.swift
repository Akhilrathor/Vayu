//
//  SizeClassViewController.swift
//  InterviewPrep
//
//  Created by Akhilesh Rathor on 20/07/25.
//
/*
 30) what is size classes in ios?
 Ans.
 
 Size classes in iOS are a way to categorize screen size and aspect ratio, allowing developers to create adaptable layouts that work across different devices and orientations. They simplify layout design by abstracting away the specific details of individual devices, focusing instead on two key traits: compact and regular, for both width and height.
 
 Each view controller (or view) in your app has a size class for both width and height, resulting in combinations like:

 * Regular width / Regular height (e.g., iPad full screen)

 * Compact width / Regular height (e.g., iPhone in portrait)

 * Regular width / Compact height (e.g., iPhone in landscape, iPad in some multitasking)

 * Compact width / Compact height
 
 */

import UIKit

class SizeClassViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
