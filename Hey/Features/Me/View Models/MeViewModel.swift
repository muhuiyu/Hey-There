//
//  MeViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/3/22.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class MeViewModel: BaseViewModel {
    
    override func setup(appCoordinator: AppCoordinator?) {
        super.setup(appCoordinator: appCoordinator)
        Task {
            
        }
    }
}

extension MeViewModel {
    var displayTitle: String { AppText.MainTab.me }
    var displayRefreshControlString: String { AppText.General.pullToRefresh }
    var userEmail: String? {
        return appCoordinator?.userManager.email
    }
    var memberID: String? {
//        return appCoordinator?.userManager.memberID
        return "MEMBERID"
    }
    var userName: String? {
        return appCoordinator?.userManager.fullName
    }
    var userImageURL: URL? {
        guard let path = appCoordinator?.userManager.avatarStoragePath else { return nil }
        return URL(string: path)
    }
}
// MARK: - Constants and strings
extension MeViewModel {
    struct Constants {
        static let datePickerIndexPath: IndexPath = IndexPath(row: 0, section: 0)
        static let qrCodeSectionIndex = 0
        static let categorySectionIndex = 1
        static let resultSectionIndex = 2
        static let numberOfSections = 2
    }
}
// MARK: - Delegate
extension MeViewModel {
    @objc
    func didTapOnNotification() {
        
    }
}
