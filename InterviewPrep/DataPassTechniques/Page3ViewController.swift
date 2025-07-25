//
//  Page3ViewController.swift
//  InterviewPrep
//
//  Created by Akhilesh Rathor on 7/25/25.
//
/*
 42) how to pass data 3 page to 2 page in Swift?
 Ans.
    1. Using Delegate (Preferred for backward data passing)
    2. Using Closures (Simple and lightweight)
    3. Using NotificationCenter (Loose coupling)
 
 */


protocol Page2Delegate: AnyObject {
    func sendDataBack(data: String)
}

import UIKit

//1. Using Delegate (Preferred for backward data passing)

class Page3ViewController: UIViewController {
    weak var delegate: Page2Delegate?
    
    var onDataBack: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("Deinitialized Page3ViewController")
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
//        delegate?.sendDataBack(data: "Data from Page 3")
        NotificationCenter.default.post(name: .dataFromPage3, object: nil, userInfo: ["data": "Hello"])
        onDataBack?("Hello from Page 3")
        self.navigationController?.popViewController(animated: true)
    }
}
