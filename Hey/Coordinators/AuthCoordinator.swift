//
//  AuthCoordinator.swift
//  Ohana
//
//  Created by Mu Yu on 10/15/22.
//

import UIKit

class AuthCoordinator: BaseCoordinator {
    
    let viewModel = AuthenticationViewModel()
}

// MARK: - Navigation
extension AuthCoordinator {
    func requestGoogleSignIn() {
        viewModel.googleSignIn()
    }
    func requestAppleSignIn() {
        viewModel.appleSignIn()
    }
    func requestEmailSignIn() {
        // TODO: - 
    }
}
