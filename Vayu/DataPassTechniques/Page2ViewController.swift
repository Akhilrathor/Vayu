//
//  Page2ViewController.swift
//  InterviewPrep
//
//  Created by Akhilesh Rathor on 7/25/25.
//

import UIKit
import Foundation

class Page2ViewController: UIViewController, Page2Delegate {

    override func viewDidLoad() {
        super.viewDidLoad()
//        goToPage3()
        NotificationCenter.default.addObserver(self, selector: #selector(receivedData(_:)), name: .dataFromPage3, object: nil)
    }
    
    deinit {
        print("Deinitialized Page2ViewController")
    }

    @IBAction func btnNextAction(_ sender: Any) {
        goToPage3()
    }
    func sendDataBack(data: String) {
        print("Received: \(data)")
    }

    @objc func receivedData(_ notification: Notification) {
        if let data = notification.userInfo?["data"] as? String {
            print("Received: \(data)")
        }
    }

//    func goToPage3() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "Page3ViewController") as! Page3ViewController
//        vc.delegate = self
//        navigationController?.pushViewController(vc, animated: true)
//
//    }
    
    func goToPage3() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Page3ViewController") as! Page3ViewController
        vc.onDataBack = { data in
            print("Data from Page 3: \(data)")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension Notification.Name {
    static let dataFromPage3 = Notification.Name("dataFromPage3")
}
