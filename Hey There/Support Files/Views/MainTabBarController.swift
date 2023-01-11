//
//  MainTabBarController.swift
//  Ohana
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    weak var appCoordinator: AppCoordinator?
    var childCoordinators = [CoordinatorID: BaseCoordinator]()
    
    deinit {
        // TODO: - remove notification center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.Brand.primary
    }
}

// MARK: - View Configs
extension MainTabBarController {
    func configureTabBarItems() {
        configureInitialTabBarItems()
    }
    
    private func configureInitialTabBarItems() {
        var mainViewControllers = [UINavigationController]()
        TabBarCategory.allCases.forEach { [weak self] category in
            guard let _ = self else { return }
            if let viewController = generateViewController(category) {
                mainViewControllers.append(viewController)
            }
        }
        self.viewControllers = mainViewControllers
    }
    
    private func generateViewController(_ category: TabBarCategory) -> UINavigationController? {
        let viewController = category.viewController
        viewController.appCoordinator = self.appCoordinator
        viewController.tabBarItem = category.tabBarItem
        
        guard let coodinator = self.childCoordinators[category.coordinatorID] else { return nil }
        
        viewController.coordinator = coodinator
        coodinator.navigationController.setViewControllers([viewController], animated: true)
        return coodinator.navigationController
    }
}

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
}
