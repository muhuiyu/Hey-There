//
//  UserManager.swift
//  Ohana
//
//  Created by Mu Yu on 10/15/22.
//

import UIKit
import HealthKit
import Firebase

class UserManager {
    var appCoordinator: AppCoordinator?
    private var user: AppUser?
    
    var signInMethod: SignInMethod?
}
// MARK: - Get data
extension UserManager {
    var id: UserID? { return user?.id }
    var avatarStoragePath: String? { return user?.avatarStoragePath }
    var email: String? { return user?.email }
    var createdTime: Date? { return user?.createdTime }
    var fullName: String? { return user?.fullName }
}
// MARK: - Set data
extension UserManager {
    func setData(from firebaseUser: User) {
        if let _ = user {
            user?.setData(from: firebaseUser)
        } else {
            user = AppUser(from: firebaseUser)
        }
    }
    func setData(to attribute: AppUser.Attribute, as value: Any) {
        switch attribute {
        case .id:
            if let value = value as? UserID {
                user?.id = value
            }
        case .fullName:
            if let value = value as? String {
                user?.fullName = value
            }
        case .email:
            if let value = value as? String {
                user?.email = value
            }
        case .avatarStoragePath:
            if let value = value as? String {
                user?.avatarStoragePath = value
            }
        case .createdTime:
            if let value = value as? Date {
                user?.createdTime = value
            }
        }
    }
    func clearData() {
        user = nil
        signInMethod = nil
    }
}
extension UserManager {

}
