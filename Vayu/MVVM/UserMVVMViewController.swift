//
//  UserMVVMViewController.swift
//  Vayu
//
//  Created by Akhilesh Rathor on 10/07/25.
//
/*
26) b) What is MVVM?
 Ans.
 
 MVVM (Model-View-ViewModel) improves separation of concerns:

 Model: Manages data and business logic.

 View: Handles the UI and user interactions.

 ViewModel: Handles presentation logic, exposes data for the View, manages state.

 Key benefit: Reduces UI code in the View and makes business logic more testable.
 
 */

import UIKit

class UserMVVMViewController: UIViewController {
    var viewModel: UserViewModel!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    private func bindViewModel() {
        nameTextField.text = viewModel.name
        ageTextField.text = viewModel.age
    }

    @IBAction func nameChanged(_ sender: UITextField) {
        viewModel.updateName(sender.text ?? "")
        bindViewModel()
    }

    @IBAction func ageChanged(_ sender: UITextField) {
        if let age = Int(sender.text ?? "") {
            viewModel.updateAge(age)
            bindViewModel()
        }
    }
}


/*
 Q. When to Use Each Pattern?
 MVC:

 Good for small, simple projects or quick prototypes.

 Easier for beginners and rapid development.

 MVVM:

 Better for large, complex apps.

 Preferred with SwiftUI due to built-in data binding.

 Improves testability and maintainability.
 
 Q: What are the main drawbacks of MVC in iOS?

 A: The Controller can become very large and hard to maintain, known as the "Massive View Controller" problem.

 Q: How does MVVM solve problems found in MVC?

 A: MVVM introduces a ViewModel to handle presentation logic, which reduces the burden on the View and Controller, making code more modular and testable.

 Q: Why is MVVM preferred with SwiftUI?

 A: SwiftUI is designed around MVVM principles, supporting automatic data binding between the View and ViewModel, which simplifies UI updates and state management.

Q: Summary Statement for Interviews

A: "MVC is simple and good for small projects, but can lead to bloated controllers as apps grow. MVVM, especially with SwiftUI, offers better separation of concerns, testability, and scalability by introducing a ViewModel layer. I choose between them based on project size and complexity.
 */
