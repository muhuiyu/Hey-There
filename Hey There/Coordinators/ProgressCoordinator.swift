//
//  ProgressCoordinator.swift
//  Get Fit
//
//  Created by Mu Yu on 8/31/22.
//

import UIKit

class ProgressCoordinator: BaseCoordinator {
    enum Destination {
        case addProgress
    }
}

// MARK: - ViewController List
extension ProgressCoordinator {
    private func makeViewController(for destination: Destination) -> ViewController? {
        switch destination {
        case .addProgress:
            // TODO: -
            return BaseViewController()
        }
    }
}

// MARK: - Navigation
extension ProgressCoordinator {
    func showAddProgress() {
        guard let viewController = makeViewController(for: .addProgress) else { return }
        let options = ModalOptions(isEmbedInNavigationController: true, isModalInPresentation: true)
        self.navigate(to: viewController, presentModally: true, options: options)
    }
}
