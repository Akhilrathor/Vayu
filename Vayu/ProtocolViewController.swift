//
//  ProtocolViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 21/09/25.
//
/*
Q.65) what is protocol and how may way we can create optional method in protocol and what is difference in that both type.
 Ans.
 
 Definition
 A protocol in Swift defines a blueprint of methods, properties, and requirements that conforming types (classes, structs, enums, actors) must implement. It enables abstraction, reusability, and polymorphism without inheritance.
 
 Why Protocols Matter
     •    Encourage protocol-oriented programming (POP), which Swift favors over class inheritance.
     •    Enable decoupling and dependency inversion (common in delegate patterns).
     •    Promote generic design and flexibility—code can work with any conforming type instead of concrete classes.
 
 Why Optional Methods?
 In many designs (like delegates), not all callbacks are always relevant. Making certain methods optional:
     •    Avoids boilerplate.
     •    Lets conforming types adopt only the parts they need.
     •    Provides flexibility while maintaining shared contracts.
 
 Two Approaches to Optional Methods
 1. @objc optional (True optional – Objective‑C interop)
     •    Works only with classes, not structs/enums.
     •    Requires  @objc  before protocol and  @objc optional  before each optional method/property.
     •    Uses dynamic dispatch (Objective-C runtime).
     •    Must use optional chaining when calling ( delegate?.method?() ).
 
 When to use:
     •    Interoperating with Objective-C frameworks (UIKit/AppKit).
     •    Need runtime checks ( responds(to:) ).
     •    Example:  UITableViewDelegate ,  UICollectionViewDelegate .
 
 
 2. Protocol + Default Implementation (Swift-native, effective optional)
     •    Works with all types (class/struct/enum).
     •    Provide default implementations in a protocol extension.
     •    No runtime checks needed; method always exists (default or overridden).
     •    Safer, more Swifty, preferred for modern codebases.
 
 
 Common Interview Follow-Ups
 
 Q: Why can’t Swift have  optional  methods natively (like Obj-C)?
 Swift prioritizes compile-time safety. True optional requirements would require runtime checks, which contradict Swift’s safety-first philosophy. Instead, Swift uses protocol extensions.
 
 Q: How do you check if an @objc optional is implemented?
 Use optional chaining ( delegate?.method?() ) or  responds(to:) .
 
 Q: Can structs adopt @objc optional protocols?
 No. Structs/enums are not Objective-C compatible.
 
 Q: Weak delegates vs default implementations?
     •    Weak delegate prevents retain cycles, but you still need  @objc optional  if you want true optionals.
     •    Protocol extensions provide no-op or default implementations, avoiding optional checks.
 
 Q: Can we have optional properties?
     •    With  @objc optional  – yes.
     •    With default implementation – simulate by making a requirement and providing a computed default value.
 
 */
import UIKit

@objc protocol MyProtocol {
    @objc optional func optionalMethod() // Must be marked @objc optional
}

protocol RefreshDelegate {
    func didStartRefresh()
    func shouldRefresh() -> Bool
}

extension RefreshDelegate {
    func didStartRefresh() {} // no-op default
    func shouldRefresh() -> Bool { true }
}

struct MyList: RefreshDelegate {}


class MyClass: MyProtocol {
    // No implementation needed for optionalMethod

    // If you implement it, it becomes available on `MyClass` too:
    // func optionalMethod() {
    //     print("optionalMethod implemented in MyClass")
    // }
}


protocol P { func f() }
extension P { func f() { print("ext") } }
struct S: P { func f() { print("S") } }


class ProtocolViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Usage (requires optional chaining)
        let obj = MyClass()
        // Note: Optional requirements are only visible via the protocol type, not the concrete class
        // unless the class actually implements them. Upcast to `MyProtocol` to access `optionalMethod`.
        let proto: MyProtocol = obj
        proto.optionalMethod?() // Safe call; does nothing if not implemented
        
        _ = MyList().shouldRefresh() // Uses default; explicitly ignore result
        
        let p: P = S()
        p.f()        // "S" (dynamic, protocol requirement)
    }
    


}

