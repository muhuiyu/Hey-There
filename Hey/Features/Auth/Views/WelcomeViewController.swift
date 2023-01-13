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
    private let googleButton = TextButton(frame: .zero, buttonType: .primary)
    private let appleButton = TextButton(frame: .zero, buttonType: .primary)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }
}
// MARK: - Actions
extension WelcomeViewController {
    private func didTapGoogleSignin() {
        guard let coordinator = coordinator as? AuthCoordinator else { return }
        coordinator.requestSignIn(with: .google)
    }
    private func didTapAppleSignin() {
        guard let coordinator = coordinator as? AuthCoordinator else { return }
        coordinator.requestSignIn(with: .apple)
    }
}
// MARK: - View Config
extension WelcomeViewController {
    private func configureViews() {
        titleView.text = AppText.appName
        titleView.font = UIFont.h2
        titleView.textColor = UIColor.label
        view.addSubview(titleView)
        
        googleButton.tapHandler = {[weak self] in
            self?.didTapGoogleSignin()
        }
        googleButton.text = AppText.Auth.continueWithGoogle
        googleButton.alignment = .center
        view.addSubview(googleButton)
        
        appleButton.tapHandler = {[weak self] in
            self?.didTapAppleSignin()
        }
        appleButton.text = AppText.Auth.continueWithGoogle
        appleButton.alignment = .center
        view.addSubview(appleButton)
    }
    private func configureConstraints() {
        titleView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
        googleButton.snp.remakeConstraints { make in
            make.height.equalTo(Constants.TextButton.Height.large)
            make.leading.trailing.equalTo(appleButton)
            make.bottom.equalTo(appleButton.snp.top).offset(-Constants.Spacing.medium)
        }
        appleButton.snp.remakeConstraints { make in
            make.height.equalTo(Constants.TextButton.Height.large)
            make.leading.trailing.bottom.equalTo(view.layoutMarginsGuide)
        }
    }
}
