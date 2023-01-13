//
//  TabBarCategory.swift
//  Hey
//
//  Created by Mu Yu on 1/12/23.
//

import Foundation
import UIKit

enum TabBarCategory: Int, CaseIterable {
    case chat = 0
    case me
//    case money
    
    var title: String {
        switch self {
        case .chat: return AppText.MainTab.chat
        case .me: return AppText.MainTab.me
//        case .money: return AppText.MainTab.progress
        }
    }
    var inactiveImageValue: UIImage? {
        switch self {
        case .chat: return UIImage(systemName: Icons.message)
        case .me: return UIImage(systemName: Icons.person)
//        case .money: return UIImage(systemName: Icons.chartBar)
        }
    }
    var activeImageValue: UIImage? {
        switch self {
        case .chat: return UIImage(systemName: Icons.messageFill)
        case .me: return UIImage(systemName: Icons.personFill)
//        case .money: return UIImage(systemName: Icons.chartBarFill)
        }
    }
    var viewController: BaseViewController {
        switch self {
        case .chat: return ChatListViewController(viewModel: ChatListViewModel())
        case .me: return MeViewController(viewModel: MeViewModel())
//        case .money: return ProgressViewController()
        }
    }
    var tabBarItem: UITabBarItem {
        let item = UITabBarItem(title: self.title, image: self.inactiveImageValue, tag: self.rawValue)
        item.selectedImage = self.activeImageValue
        return item
    }
    var coordinatorID: CoordinatorID {
        switch self {
        case .chat: return .chat
        case .me: return .me
//        case .money: return .money
        }
    }
    
    func makeCoordinator(navigationController: UINavigationController,
                         parentCoordinator: AppCoordinator) -> BaseCoordinator {
        switch self {
        case .chat:
            return ChatCoordinator(navigationController: navigationController,
                                   parentCoordinator: parentCoordinator)
        case .me:
            return MeCoordinator(navigationController: navigationController,
                                 parentCoordinator: parentCoordinator)
        }
    }
}
