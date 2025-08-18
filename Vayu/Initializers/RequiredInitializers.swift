//
//  RequiredInitializers.swift
//  InterviewPrep
//
//  Created by Akhilesh Rathor on 28/06/25.
//
/*
 4. Required Initializers:-
 
 A required initializers, like its name implies, is an initializer that you must implement if you're subclassing.
 */

import UIKit

class RequiredInitializers: UIViewController {

    var viewModel: ViewModel
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        self.viewModel = ViewModel()
        super.init(coder: coder) // Called when using Interface Builder (Storyboard/XIB)
        // fatalError("init(coder:) has not been implemented") // Uncomment if not using Interface Builder
    }

    /*
     Why do we need this `required init?(coder:)`?

     This initializer is required when we are using Interface Builder (like Storyboards or XIBs).
     
     Xcode uses NSCoder to decode the UI components (like UILabels, UIButtons, etc.) that we build in Storyboard.
     It translates the UI design into code behind the scenes using this coder mechanism.

     So, if we use Storyboards, we must implement `init?(coder:)` and call `super.init(coder:)`.

     If we are not using Storyboards, and creating UI programmatically, we can just put:
     `fatalError("init(coder:) has not been implemented")` to indicate it's not supported.
     */

}

class ViewModel {
    
}
