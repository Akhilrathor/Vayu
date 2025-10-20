//
//  CircularReferenceViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 14/10/25.
//
/*Q. 89) what is circular reference?
 Ans.
 
 A circular reference (also called a retain cycle) occurs when two or more objects hold strong references to each other, preventing them from being deallocated from memory.
 
 ✅ Fix using weak or unowned:
 class Apartment {
     weak var tenant: Person?
     deinit { print("Apartment deinitialized") }
 }

 
 Common Interview Questions & Answers

 1️⃣ What causes a circular reference in Swift?
 A circular reference happens when two or more objects have strong references to each other, preventing ARC from deallocating them.

 2️⃣ How do you break a retain cycle?
 Use weak or unowned references for one side of the relationship — usually the one that doesn’t “own” the other.

 Use weak when the reference can become nil.

 Use unowned when the reference will always have a value during the lifetime of the relationship.

 3️⃣ What’s the difference between weak and unowned?

 weak references are optional and automatically set to nil when the referenced object is deallocated.

 unowned references are non-optional and assumed to always have a valid object; accessing after deallocation causes a runtime crash.

 4️⃣ Give an example of circular reference in closures.
 Closures capture self strongly by default, which can cause a retain cycle:

 class ViewController: UIViewController {
     var name = "Akhilesh"
     lazy var showName = {
         print(self.name)
     }
 }


 ✅ Fix using capture list:

 lazy var showName = { [weak self] in
     print(self?.name ?? "")
 }

 🔹 Quick Tip for Interviews:
 Whenever you use a closure or delegate, think — “Is this capturing self strongly?” If yes, use [weak self] or [unowned self] to avoid circular references.
 */

import UIKit

class CircularReferenceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var john: PersonRef? = PersonRef()
        var flat: Apartment? = Apartment()

        john?.apartment = flat
        flat?.tenant = john

        john = nil
        flat = nil  // ❌ Neither deinit is called — memory leak!
    }

}

class PersonRef {
    var apartment: Apartment?
    deinit { print("Person deinitialized") }
}

class Apartment {
    var tenant: PersonRef?
    deinit { print("Apartment deinitialized") }
}
