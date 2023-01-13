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
