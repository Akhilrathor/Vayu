//
//  UIResponderViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 09/07/25.
//
/*
 25) What is UIResponder in iOS?
 Ans.
 
 UIResponder is the base class that enables views and controllers to respond to events like touch, motion, and remote control by using the responder chain.
 */
import UIKit

class UIResponderViewController: UIViewController {

    @IBOutlet weak var customVW: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

class CustomView: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touch began")
    }
}
