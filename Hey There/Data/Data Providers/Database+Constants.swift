//
//  Database+Constants.swift
//  Hey There
//
//  Created by Mu Yu on 1/11/23.
//

import Foundation

extension Database {
    struct FirebaseCollection {
        static let users = "users"
        static let friends = "friends"
        static let chats = "chats"
        static let messages = "messages"
    }
    
    struct Attribute {
        static let members = "members"
        static let userID = "userID"
        static let year = "year"
        static let month = "month"
        static let day = "day"
    }
}
