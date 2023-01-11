//
//  BaseMVVMViewController.swift
//  Ohana
//
//  Created by Mu Yu on 12/30/22.
//

import Foundation
import RxSwift

class BaseMVVMViewController<T: ViewModelType>: BaseViewController {
    internal let disposeBag = DisposeBag()
    
    let viewModel: T
    
    init(appCoordinator: AppCoordinator? = nil,
         coordinator: BaseCoordinator? = nil,
         viewModel: T) {
        self.viewModel = viewModel
        super.init(appCoordinator: appCoordinator, coordinator: coordinator)
    }
}
