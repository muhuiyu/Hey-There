//
//  FirebaseDataProvider.swift
//  Ohana
//
//  Created by Mu Yu on 10/22/22.
//

import Foundation
//import Firebase

class FirebaseDataProvider {
//    internal let noteRef: CollectionReference = Firestore.firestore().collection(FirebaseCollection.notes)
//    internal let chatRef: CollectionReference = Firestore.firestore().collection(FirebaseCollection.chats)
    
    struct FirebaseCollection {
        static let notes = "notes"
        static let chats = "chats"
    }
    
    struct Attribute {
        static let userID = "userID"
        static let year = "year"
        static let month = "month"
        static let day = "day"
        static let body = "body"
        static let updatedTime = "updatedTime"
    }
}

extension FirebaseDataProvider {
    func signIn(email: String, password: String) async {
        
    }
}

// MARK: - Note
extension FirebaseDataProvider {
//    func updateData(at noteID: NoteID, _ content: String) async throws {
        // TODO: - connect to Firebase
//        let data: [String: Any] = [
//            Attribute.body: content,
//            Attribute.updatedTime: Date(),
//        ]
//        try await noteRef.document(noteID).updateData(data)
//    }
//    func getData(at noteID: NoteID) async throws -> Note? {
        // TODO: - connect to Firebase
//        let snapshot = try await noteRef.document(noteID).getDocument()
//        return try Note(snapshot: snapshot)
//        return nil
//    }
}
