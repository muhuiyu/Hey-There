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
        // testing
        configureCoordinators()
        setupMainTabBar()
        configureManagers()
        showHome()
        window.makeKeyAndVisible()
        
        
//        showLoadingScreen()
//        configureCoordinators()
//        setupMainTabBar()
//        configureAuth()
//
//        Task {
//            configureManagers()
//            await authCoordinator?.viewModel.checkPreviousSignInSession()
//            await window.makeKeyAndVisible()
//        }
    }
}
// MARK: - Services and managers
extension AppCoordinator {
    private func configureManagers() {
        cacheManager.appCoordinator = self
        userManager.appCoordinator = self
        dataProvider.appCoordinator = self
    }
    private func configureAuth() {
        let coordinator = AuthCoordinator(navigationController: UINavigationController(tintColor: UIColor.Brand.primary),
                                          parentCoordinator: self)
        
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.coordinator = coordinator
        DispatchQueue.main.async {
            coordinator.navigationController.setViewControllers([ welcomeViewController ], animated: true)
        }
        coordinator.navigationController.navigationItem.largeTitleDisplayMode = .always
        coordinator.navigationController.navigationBar.prefersLargeTitles = true
        
        coordinator.viewModel.appCoordinator = self
        coordinator.viewModel.state
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { state in
                switch state {
                case .loading:
                    self.showLoadingScreen()
                case .signedIn:
                    self.showHome()
                case .signedOut:
                    self.showLogin()
                }
            })
            .disposed(by: disposeBag)
        
        self.authCoordinator = coordinator
    }
}
// MARK: - UI Setup
extension AppCoordinator {
    /// Initializes coordinators
    /// Tab coordinators have their own different navigationControllers
    private func configureCoordinators() {
        let firstNavigationController = UINavigationController(tintColor: UIColor.Brand.primary)
        firstNavigationController.navigationItem.largeTitleDisplayMode = .always
        firstNavigationController.navigationBar.prefersLargeTitles = true
        
        self.childCoordinators[.home] = HomeCoordinator(navigationController: firstNavigationController,
                                                        parentCoordinator: self)
        
        let secondNavigationController = UINavigationController(tintColor: UIColor.Brand.primary)
        secondNavigationController.navigationItem.largeTitleDisplayMode = .always
        secondNavigationController.navigationBar.prefersLargeTitles = true
        self.childCoordinators[.chat] = ChatCoordinator(navigationController: secondNavigationController,
                                                        parentCoordinator: self)
        
        // TODO: - update to money
        let thirdNavigationController = UINavigationController(tintColor: UIColor.Brand.primary)
        thirdNavigationController.navigationItem.largeTitleDisplayMode = .always
        thirdNavigationController.navigationBar.prefersLargeTitles = true
        self.childCoordinators[.money] = ProgressCoordinator(navigationController: thirdNavigationController,
                                                             parentCoordinator: self)
        
        let forthNavigationController = UINavigationController(tintColor: UIColor.Brand.primary)
        forthNavigationController.navigationItem.largeTitleDisplayMode = .never
        forthNavigationController.navigationBar.prefersLargeTitles = false
        self.childCoordinators[.me] = MeCoordinator(navigationController: forthNavigationController,
                                                    parentCoordinator: self)
    }
    private func setupMainTabBar() {
        mainTabBarController = MainTabBarController()
        configureMainTabBar()
    }
    private func configureMainTabBar() {
        mainTabBarController?.appCoordinator = self
        mainTabBarController?.childCoordinators = childCoordinators
        mainTabBarController?.configureTabBarItems()
    }
}

// MARK: - Generic Navigation
extension AppCoordinator {
    private func changeRootViewController(to viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        window.rootViewController = viewController
    }
}

// MARK: - Navigation
extension AppCoordinator {
    func showLoadingScreen(forceReplace: Bool = false, animated: Bool = true) {
        print("Loading screen")
//        changeRootViewController(to: LoadingScreenViewController(appCoordinator: self))
    }
    func showHome(forceReplace: Bool = true, animated: Bool = true) {
        changeRootViewController(to: self.mainTabBarController)
    }
    func showLogin(forceReplace: Bool = false, animated: Bool = true) {
        changeRootViewController(to: self.authCoordinator?.navigationController)
    }
}
