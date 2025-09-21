//
//  WeakUnownedViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 26/08/25.
//
/*
 Q. 58) what is weak and unowned keyword in ios?
 Ans.
 
 Weak:-
 * A weak reference is a reference that does not increase the reference count of an object.

 * When the referenced object is deallocated, the weak reference is automatically set to nil.

 * Therefore, a weak property must always be declared as an optional type.

 * Use Case: When the referenced object can become nil during the lifetime of the reference, such as in delegate relationships.
 
 
 Unowned:-
 * An unowned reference is also a non-owning reference (does not increase reference count).

 * Unlike weak, an unowned reference is assumed to always have a value (non-optional).

 * If the referenced object has been deallocated and you try to access it, this causes a runtime crash.

 * Use Case: When both objects should always exist together—the reference should never be nil as long as the referencing object is alive (example: parent and child; closure capturing self).
 */

import UIKit

class WeakUnownedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var person: PersonWeak? = PersonWeak(name: "Alex")
        var dog: Pet? = Pet(type: "Dog", owner: person!)

        person?.pet = dog

        // Calling methods
        person?.walkPet()     // Dog says Woof!   (weak -> optional)
        dog?.showOwner()      // My owner is Alex (unowned -> non-optional)

        // Deallocation
        person = nil   // Person deallocated, pet becomes nil automatically
        dog = nil      // Pet deallocated
    }
    

}

class PersonWeak {
    var name: String
    weak var pet: Pet?   // weak, can become nil

    init(name: String) {
        self.name = name
    }

    func walkPet() {
        pet?.makeSound()   // optional call because pet is weak
    }

    deinit {
        print("\(name) is deallocated")
    }
}

class Pet {
    var type: String
    unowned var owner: PersonWeak   // unowned, must exist

    init(type: String, owner: PersonWeak) {
        self.type = type
        self.owner = owner
    }

    func makeSound() {
        print("\(type) says Woof!")
    }

    func showOwner() {
        print("My owner is \(owner.name)")  // direct call (non-optional)
    }

    deinit {
        print("\(type) is deallocated")
    }
}

