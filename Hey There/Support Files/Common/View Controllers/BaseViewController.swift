//
//  BaseViewController.swift
//  Ohana
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class BaseViewController: ViewController {
    
    // MARK: - Coordinators
    weak var appCoordinator: AppCoordinator?
    weak var coordinator: BaseCoordinator?
    
    private lazy var refreshControl = UIRefreshControl()
    
    init(appCoordinator: AppCoordinator? = nil,
         coordinator: BaseCoordinator? = nil) {
        super.init()
        self.appCoordinator = appCoordinator
        self.coordinator = coordinator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - View Config
extension BaseViewController {
    
}
