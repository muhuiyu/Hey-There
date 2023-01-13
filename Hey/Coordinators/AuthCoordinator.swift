//
//  AuthCoordinator.swift
//  Ohana
//
//  Created by Mu Yu on 10/15/22.
//

import UIKit
import RxRelay

class AuthCoordinator: BaseCoordinator {
    
    private let viewModel: AuthenticationViewModel
    
    override init(navigationController: UINavigationController,
                  parentCoordinator: AppCoordinator?) {
        viewModel = AuthenticationViewModel()
        viewModel.appCoordinator = parentCoordinator
        super.init(navigationController: navigationController, parentCoordinator: parentCoordinator)
        
        DispatchQueue.main.async {
            self.configureControllers()
        }
    }
}

// MARK: - Navigation
extension AuthCoordinator {
    func setup() async {
        await viewModel.checkPreviousSignInSession()
    }
    func requestSignIn(with method: SignInMethod) {
        viewModel.signIn(with: method)
    }
    func requestSignOut() {
        viewModel.signOut()
    }
    var signInState: BehaviorRelay<SignInState> {
        return viewModel.state
    }
}

// MARK: - Setup
extension AuthCoordinator {
    private func configureControllers() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.coordinator = self
        navigationController.setViewControllers([ welcomeViewController ], animated: true)
        navigationController.navigationItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.prefersLargeTitles = true
    }
}
