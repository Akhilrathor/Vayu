//
//  LoginView.swift
//  InterviewPrep
//
//  Created by Akhilesh Rathor on 27/07/25.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var navigateToUIKit = false
    var body: some View {
            NavigationStack {
                ZStack {
                    Color.black.ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("Log In")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                            .padding(.top, 40)

                        TextField("Username", text: $username)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)

                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)

                        Button(action: {
                            navigateToUIKit = true
                        }) {
                            Text("Continue")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }

                    }
                    .padding(.horizontal, 30)
                }
                .navigationDestination(isPresented: $navigateToUIKit) {
                    UIKitWrapperView()
                }
            }
        }
}

struct UIKitWrapperView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Page2ViewController") as! Page2ViewController
    return vc
        }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}


#Preview {
    LoginView()
}
