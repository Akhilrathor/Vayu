//
//  UserViewModel.swift
//  InterviewPrep
//
//  Created by Akhilesh Rathor on 10/07/25.
//

import Foundation

class UserViewModel {
    private var user: User2

    var name: String {
        return user.name
    }

    var age: String {
        return "\(user.age)"
    }

    init(user: User2) {
        self.user = user
    }

    func updateName(_ name: String) {
        user.name = name
    }

    func updateAge(_ age: Int) {
        user.age = age
    }
}
