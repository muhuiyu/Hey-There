//
//  Chat.swift
//  Ohana
//
//  Created by Mu Yu on 11/6/22.
//

import Foundation
import Firebase

typealias ChatID = String
typealias ChatList = [Chat]

struct Chat {
    let id: ChatID
    var members: [UserID]
    var admins: [UserID]
    var title: String
    var createdTime: Date
    var imageStoragePath: String?
    var lastMessage: Message?
}

extension Chat {
    /// Returns the name concatenation of given users
    func getUserNamesConcatenation(cachedUsers: [UserID: AppUser],
                                   shouldRemoveCurrentUser: Bool = true,
                                   currentUserID: UserID,
                                   separator: String = ", ") -> String {
        
        let memberIDs = shouldRemoveCurrentUser ? Array(members.drop(while: { $0 == currentUserID })) : members
        return memberIDs
            .compactMap({ cachedUsers[$0]?.fullName })
            .joined(separator: separator)
    }
}

// MARK: - Codable
extension Chat: Codable {
    struct ChatData: Codable {
        var members: [UserID]
        var admins: [UserID]
        var title: String
        var createdTime: Date
        var imageStoragePath: String?
    }
    init(snapshot: DocumentSnapshot) throws {
        self.id = snapshot.documentID
        let data = try snapshot.data(as: ChatData.self)
        self.members = data.members
        self.admins = data.admins
        self.title = data.title
        self.createdTime = data.createdTime
        self.imageStoragePath = data.imageStoragePath
        self.lastMessage = nil
    }
}
