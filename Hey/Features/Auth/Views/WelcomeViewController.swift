//
//  WelcomeViewController.swift
//  Hey There
//
//  Created by Mu Yu on 1/11/23.
//

import Foundation
import UIKit

class WelcomeViewController: BaseViewController {
    private let titleView = UILabel()
    private let googleLoginButton = TextButton(frame: .zero, buttonType: .primary)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }
}
// MARK: - Actions
extension WelcomeViewController {
    private func didTapGoogleLogin() {
        guard let coordinator = coordinator as? AuthCoordinator else { return }
        coordinator.requestGoogleSignIn()
    }
}
// MARK: - View Config
extension WelcomeViewController {
    private func configureViews() {
        titleView.text = AppText.appName
        titleView.font = UIFont.h2
        titleView.textColor = UIColor.label
        view.addSubview(titleView)
        
        googleLoginButton.tapHandler = {[weak self] in
            self?.didTapGoogleLogin()
        }
        googleLoginButton.text = AppText.Auth.continueWithGoogle
        googleLoginButton.alignment = .center
        view.addSubview(googleLoginButton)
    }
    private func configureConstraints() {
        titleView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
        googleLoginButton.snp.remakeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.layoutMarginsGuide)
        }
    }
}
