//
//  Database+Chats.swift
//  Ohana
//
//  Created by Mu Yu on 11/10/22.
//

import Foundation
import Firebase

// MARK: - Update data
extension Database {
    //    func updateMealLog(for userID: UserID, to value: MealLog) async -> VoidResult {
    //        return .success
    //    }
    //    func removeMealLog(for userID: UserID) async -> VoidResult {
    //        return .success
    //    }
}

// MARK: - Fetch chats
extension Database {
    func getChat(for chatID: ChatID) async -> Chat? {
        do {
            let snapshot = try await chatsRef.document(chatID).getDocument()
            return try Chat(snapshot: snapshot)
        } catch {
            ErrorHandler.shared.handle(error)
            return nil
        }
    }
    func getMessages(for chatID: ChatID) async -> [Message] {
        return await fetchMessages(at: chatsRef.document(chatID))
    }
    internal func fetchMessages(at documentRef: DocumentReference) async -> [Message] {
        do {
            let messageSnapshot = try await documentRef.collection(FirebaseCollection.messages).getDocuments()
            return try messageSnapshot.documents.map({ try Message(snapshot: $0) })
        } catch {
            ErrorHandler.shared.handle(error)
            return []
        }
    }
}
// MARK: - Send / delete messages
extension Database {
    func sendMessage(from userID: UserID, to chatID: ChatID, _ content: MessageContent) {
        // TODO: -
//        switch content {
//        case .text(let content):
//            // TODO: -
//        case .image(let content):
//            // TODO: -
//        }
    }
    func deleteMessage(chatID: ChatID, messageID: MessageID) {
        // TODO: -
    }
}
// MARK: - Publisher and Listeners
extension Database {
    internal func addChatsListener(for userID: UserID) {
        chatsRef
            .whereField(Attribute.members, arrayContains: userID)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    ErrorHandler.shared.handle(error)
                    return
                }
                guard let snapshot = snapshot else { return }
                Task {
                    let result = try await self.configureChats(snapshot: snapshot)
                    self.chatsObserver.accept(result.chats)
                    self.messagesObserver.accept(result.messageDictionary)
                }
            }
    }
    internal func configureChats(snapshot: QuerySnapshot) async throws -> (chats: [ChatID: Chat],
                                                                          messageDictionary: [ChatID: MessageList]) {
        var chats = [ChatID: Chat]()
        var messageDictionary = [ChatID: MessageList]()
        
        for document in snapshot.documents {
            var chat = try Chat(snapshot: document)
            let messageList = SortedArray(unsorted: await self.fetchMessages(at: document.reference))
            chat.lastMessage = messageList.last
            chats[document.documentID] = chat
            
            objc_sync_enter(self.messagesObserverLock)
            messageDictionary[document.documentID] = messageList
            objc_sync_exit(self.messagesObserverLock)
        }
        return (chats: chats, messageDictionary: messageDictionary)
    }

}
