//
//  AppCoordinator.swift
//  Hey There
//
//  Created by Mu Yu on 1/11/23.
//

import UIKit
import RxSwift

class AppCoordinator: Coordinator {
    private let disposeBag = DisposeBag()
    private let window: UIWindow
    
    // Managers
    private(set) var userManager = UserManager()
    private(set) var cacheManager = CacheManager()
    private(set) var dataProvider = Database()
    
    // Coordinators
    private var childCoordinators = [CoordinatorID: BaseCoordinator]()
    private var authCoordinator: AuthCoordinator?
    
    // MainTabBar
    private(set) var mainTabBarController: MainTabBarController?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        showLoadingScreen()
        configureManagers()
        configureCoordinators()
        setupMainTabBar()
        
        Task {
            await authCoordinator?.setup()
            await setupDataProvider()
            await window.makeKeyAndVisible()
        }
    }
}
// MARK: - Navigation
extension AppCoordinator {
    func showLoadingScreen(forceReplace: Bool = false, animated: Bool = true) {
        changeRootViewController(to: LoadingScreenViewController(appCoordinator: self))
    }
    func showHome(forceReplace: Bool = true, animated: Bool = true) {
        changeRootViewController(to: self.mainTabBarController)
    }
    func showLogin(forceReplace: Bool = false, animated: Bool = true) {
        changeRootViewController(to: self.authCoordinator?.navigationController)
    }
    func logoutUser() {
        
    }
    /// Sets up observers of data provider
    func setupDataProvider() async {
        guard let userID = userManager.id else { return }
        await dataProvider.setup(userID: userID)
        await dataProvider.updateUserData()
    }
}
// MARK: - Setup
extension AppCoordinator {
    /// Initializes managers
    private func configureManagers() {
        cacheManager.appCoordinator = self
        userManager.appCoordinator = self
        dataProvider.appCoordinator = self
    }
    /// Initializes coordinators
    /// Tab coordinators have their own different navigationControllers
    private func configureCoordinators() {
        for category in TabBarCategory.allCases {
            let navigationController = UINavigationController(tintColor: UIColor.Brand.primary)
            navigationController.navigationItem.largeTitleDisplayMode = .always
            navigationController.navigationBar.prefersLargeTitles = true
            
            childCoordinators[category.coordinatorID] = category.makeCoordinator(navigationController: navigationController,
                                                                                 parentCoordinator: self)
        }
        configureAuth()
    }
    private func configureAuth() {
        let coordinator = AuthCoordinator(
            navigationController: UINavigationController(tintColor: UIColor.Brand.primary),
            parentCoordinator: self
        )
        coordinator.signInState
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                switch state {
                case .loading:
                    self?.showLoadingScreen()
                case .signedIn:
                    self?.showHome()
                case .signedOut:
                    self?.showLogin()
                }
            })
            .disposed(by: disposeBag)
        
        authCoordinator = coordinator
    }
}
// MARK: - Other functions
extension AppCoordinator {
    private func setupMainTabBar() {
        mainTabBarController = MainTabBarController()
        configureMainTabBar()
    }
    private func configureMainTabBar() {
        mainTabBarController?.appCoordinator = self
        mainTabBarController?.childCoordinators = childCoordinators
        mainTabBarController?.configureTabBarItems()
    }
    private func changeRootViewController(to viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        window.rootViewController = viewController
    }
}
