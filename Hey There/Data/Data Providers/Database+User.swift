//
//  Database+User.swift
//  Ohana
//
//  Created by Mu Yu on 11/10/22.
//

import Foundation
import Firebase

extension Database {
    /// Fetches single user from Firebase
    func getUser(for userID: UserID) async -> AppUser? {
        do {
            let snapshot = try await usersRef.document(userID).getDocument()
            return try AppUser(snapshot: snapshot)
        } catch {
            ErrorHandler.shared.handle(error)
            return nil
        }
    }
    /// Fetches multiple users from Firebase
    func getUsers(for userIDs: [UserID]) async -> [AppUser] {
        guard !userIDs.isEmpty else { return [] }
        
        do {
            let snapshot = try await usersRef.whereField(.documentID(), in: userIDs).getDocuments()
            return try snapshot.documents.map({ try AppUser(snapshot: $0) })
        } catch {
            ErrorHandler.shared.handle(error)
            return []
        }
    }
}
extension Database {
    /// Updates local user data to Firebase
    internal func updateUserData() async {
        do {
            guard
                let appCoordinator = appCoordinator,
                let userID = appCoordinator.userManager.id
            else { return }
            
            var data = [String: Any]()
            
            if let fullName = appCoordinator.userManager.fullName {
                data[AppUser.Attribute.fullName.rawValue] = fullName
            }
            if let email = appCoordinator.userManager.email {
                data[AppUser.Attribute.email.rawValue] = email
            }
            if let avatarStoragePath = appCoordinator.userManager.avatarStoragePath {
                data[AppUser.Attribute.avatarStoragePath.rawValue] = avatarStoragePath
            }
            let hasUser = try await usersRef.document(userID).getDocument().exists
            if !hasUser {
                data[AppUser.Attribute.createdTime.rawValue] = Date()
            }
            try await usersRef.document(userID).setData(data, merge: true)
        } catch {
            ErrorHandler.shared.handle(error)
        }
    }
}
