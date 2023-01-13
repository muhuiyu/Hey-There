//
//  MeViewController.swift
//  Hey There
//
//  Created by Mu Yu on 1/11/23.
//

import UIKit
import RxSwift
import Kingfisher

class MeViewController: BaseMVVMViewController<MeViewModel> {
    
    private let profileImageView = UIImageView()
    private let profileImageCircleView = CircleView()
    private let headerContainerView = UIView()
    
    private let nameStack = UIStackView()
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    
    private let qrCodeImageView = UIImageView()
    
    private let logoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignals()
        configureViewModel()
        configureViews()
        configureConstraints()
    }
    // Need to set `hidesBottomBarWhenPushed` to ViewControllers in MainTabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hidesBottomBarWhenPushed = false
    }
}
// MARK: - Handlers
extension MeViewController {
    @objc
    private func didTapSettings() {
        guard let coordinator = self.coordinator as? MeCoordinator else { return }
        coordinator.showSettings(viewModel: viewModel)
    }
    @objc
    private func didTapLogout() {
        guard let coordinator = self.coordinator as? MeCoordinator else { return }
        coordinator.logoutUser()
    }
}
// MARK: - View Config
extension MeViewController {
    private func configureViews() {
        navigationController?.navigationBar.tintColor = UIColor.green
        navigationController?.navigationBar.barTintColor = UIColor.green
        navigationController?.navigationBar.backgroundColor = UIColor.green
        navigationItem.rightBarButtonItem = UIBarButtonItem.makeSettingsButton(target: self,
                                                                               action: #selector(didTapSettings))
        
        headerContainerView.backgroundColor = .green
        view.addSubview(headerContainerView)
        
        if let url = viewModel.userImageURL {
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(systemName: Icons.person)
        }
        profileImageView.sizeToFit()
        profileImageCircleView.addSubview(profileImageView)
        view.addSubview(profileImageCircleView)
        
        nameLabel.text = viewModel.userName
        nameLabel.font = UIFont.bodyMedium
        nameLabel.textColor = .label
        nameLabel.textAlignment = .left
        nameStack.addArrangedSubview(nameLabel)
        
        emailLabel.text = viewModel.userEmail
        emailLabel.font = UIFont.small
        emailLabel.textColor = .secondaryLabel
        emailLabel.textAlignment = .left
        nameStack.addArrangedSubview(emailLabel)
        
        nameStack.spacing = Constants.Spacing.small
        nameStack.alignment = .center
        nameStack.axis = .vertical
        view.addSubview(nameStack)
        
        qrCodeImageView.contentMode = .scaleAspectFit
        if let memberID = viewModel.memberID {
            qrCodeImageView.image = QRCodeHelper.generateQRCode(from: memberID)
        }
        view.addSubview(qrCodeImageView)
        
        logoutButton.setTitle(AppText.General.logout, for: .normal)
        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        view.addSubview(logoutButton)
    }
    private func configureConstraints() {
        headerContainerView.snp.remakeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
        profileImageView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(Constants.Spacing.enormous * 2)
        }
        profileImageCircleView.snp.remakeConstraints { make in
            make.top.equalTo(headerContainerView.snp.bottom).offset(-Constants.Spacing.enormous)
            make.centerX.equalToSuperview()
        }
        nameStack.snp.remakeConstraints { make in
            make.top.equalTo(profileImageCircleView.snp.bottom).offset(Constants.Spacing.medium)
            make.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        qrCodeImageView.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(300)
            make.top.equalTo(nameStack.snp.bottom).offset(Constants.Spacing.medium)
        }
        logoutButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.layoutMarginsGuide)
        }
    }
    private func configureSignals() {
        // TODO: -
    }
    private func configureViewModel() {
        viewModel.setup(appCoordinator: self.appCoordinator)
    }
}
