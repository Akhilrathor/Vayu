//
//  SizeClassViewController.swift
//  Vayu
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
 
 
 52) What is Debounce and Throttling in iOS?
 Ans.
 
 Debounce waits for user to stop triggering an event before running the function, while Throttling limits the function to run only once every fixed interval.
 
 Used when: You only want to run once after the user stops typing or triggering.
 
 🛠 Example Use Case:
 Typing in a search bar – call API only after user stops typing for 500ms.
 
 Throttling:
 
 Ensures a function runs at most once in a specified time interval, even if called repeatedly.

 🧠 Used when: You want to limit execution frequency, not skip it entirely.

 🛠 Example Use Case:
 Track scroll events but update UI only every 1 second.

 
 */

import UIKit

class SizeClassViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Usage
        let debouncer = Debouncer()
        debouncer.debounce(delay: 0.5) {
            print("User stopped typing, make API call.")
        }
        
        // Usage
        let throttler = Throttler()
        throttler.throttle(delay: 1.0) {
            print("Run only once every second even if called repeatedly.")
        }
    }
    

}

class Debouncer {
    private var workItem: DispatchWorkItem?
    
    func debounce(delay: TimeInterval, action: @escaping () -> Void) {
        workItem?.cancel()
        workItem = DispatchWorkItem(block: action)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem!)
    }
}

class Throttler {
    private var isReady = true
    
    func throttle(delay: TimeInterval, action: @escaping () -> Void) {
        guard isReady else { return }
        isReady = false
        action()
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.isReady = true
        }
    }
}
