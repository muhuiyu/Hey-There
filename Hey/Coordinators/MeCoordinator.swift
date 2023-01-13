//
//  MeCoordinator.swift
//  Ohana
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class MeCoordinator: BaseCoordinator {
    enum Destination {
        case viewAccountDetails
        case viewGoals
        case viewSettings(MeViewModel)
    }
}
// MARK: - ViewController List
extension MeCoordinator {
    private func makeViewController(for destination: Destination) -> ViewController? {
        switch destination {
        case .viewSettings(let viewModel):
            let viewController = SettingViewController(appCoordinator: self.parentCoordinator,
                                                       coordinator: self)
            viewController.viewModel = viewModel
            return viewController
        case .viewAccountDetails:
            let viewController = MeAccountDetailViewController(appCoordinator: self.parentCoordinator,
                                                               coordinator: self)
            return viewController
        case .viewGoals:
            // TODO: -
            return BaseViewController()
        }
    }
}

// MARK: - Navigation
extension MeCoordinator {
    func showSettings(viewModel: MeViewModel) {
        guard let viewController = makeViewController(for: .viewSettings(viewModel)) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    func showAccountDetails() {
        guard let viewController = makeViewController(for: .viewAccountDetails) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    func showGoals() {
        guard let viewController = makeViewController(for: .viewGoals) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    func logoutUser() {
        parentCoordinator?.logoutUser()
    }
}
