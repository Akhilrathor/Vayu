//
//  UserViewController.swift
//  InterviewPrep
//
//  Created by Akhilesh Rathor on 10/07/25.
//

/*
 26) mvc vs mvvm?
    a)What is MVC?
 Ans.
 
 MVC (Model-View-Controller) is an architecture pattern that separates an app into three components:

 Model: Manages data and business logic.

 View: Handles the UI and user interactions.

 Controller: Acts as a mediator, updating the View and Model as needed.

 Common issue: Controllers often become too large ("Massive View Controller" problem).
 
 */

// ViewController (Controller + View)
import UIKit

class UserViewController: UIViewController {
    private var user = Customer(name: "Alice")

    private let nameLabel = UILabel()
    private let changeButton = UIButton(type: .system)
    private let pushToMVVMButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Setup UI
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        pushToMVVMButton.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.font = UIFont.systemFont(ofSize: 28)
        nameLabel.textAlignment = .center

        changeButton.setTitle("Change Name", for: .normal)
        changeButton.addTarget(self, action: #selector(changeName), for: .touchUpInside)
        
        pushToMVVMButton.setTitle("Push to Next Controller", for: .normal)
        pushToMVVMButton.addTarget(self, action: #selector(pushNextController), for: .touchUpInside)

        view.addSubview(nameLabel)
        view.addSubview(changeButton)
        view.addSubview(pushToMVVMButton)

        // Add constraints to center the label and button
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),

            changeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            
            pushToMVVMButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pushToMVVMButton.topAnchor.constraint(equalTo: changeButton.bottomAnchor, constant: 20)
        ])

        updateView()
    }

    @objc private func changeName() {
        user.name = "Bob"
        updateView()
    }
    
    @objc private func pushNextController() {
        // From another view controller
        let user = User2(name: "\(nameLabel.text ?? "Akhilesh")", age: 30)
        let viewModel = UserViewModel(user: user)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "UserMVVMViewController") as! UserMVVMViewController
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func updateView() {
        nameLabel.text = user.name
    }
}
