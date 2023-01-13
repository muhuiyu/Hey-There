//
//  AppUser.swift
//  Ohana
//
//  Created by Mu Yu on 11/6/22.
//

import Foundation
import Firebase

typealias UserID = String

struct AppUser {
    var id: UserID
    var email: String
    var fullName: String
    var createdTime: Date = Date()
    var avatarStoragePath: String? = nil
    
    enum Attribute: String {
        case id
        case fullName
        case email
        case createdTime
        case avatarStoragePath
    }
}
extension AppUser {
    init(from firebaseUser: User) {
        self.id = firebaseUser.uid
        self.email = firebaseUser.email ?? ""
        self.fullName = firebaseUser.displayName ?? ""
        self.avatarStoragePath = firebaseUser.photoURL?.absoluteString
    }
}
extension AppUser {
    mutating func setData(from firebaseUser: User) {
        self.id = firebaseUser.uid
        self.email = firebaseUser.email ?? ""
        self.fullName = firebaseUser.displayName ?? ""
        self.avatarStoragePath = firebaseUser.photoURL?.absoluteString
    }
}
extension AppUser: Codable, Hashable {
    struct UserData: Codable {
        var email: String = ""
        var fullName: String = ""
        var createdTime: Date = Date()
        var avatarStoragePath: String? = nil
    }
    init(snapshot: DocumentSnapshot) throws {
        self.id = snapshot.documentID
        let data = try snapshot.data(as: UserData.self)
        self.email = data.email
        self.fullName = data.fullName
        self.createdTime = data.createdTime
        self.avatarStoragePath = data.avatarStoragePath
    }
}
