//
//  Database.swift
//  Hey There
//
//  Created by Mu Yu on 1/11/23.
//

import UIKit
import RxSwift
import RxRelay
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

class Database {
    var appCoordinator: AppCoordinator?
    
    // Observers
    var chatsObserver: BehaviorRelay<[ChatID: Chat]> = BehaviorRelay(value: [:])
    var messagesObserver: BehaviorRelay<[ChatID: MessageList]> = BehaviorRelay(value: [:])
    internal let messagesObserverLock = NSObject()
    
    // Collection reference
    internal let usersRef: CollectionReference = Firestore.firestore().collection(FirebaseCollection.users)
    internal let friendsRef: CollectionReference = Firestore.firestore().collection(FirebaseCollection.friends)
    internal let chatsRef: CollectionReference = Firestore.firestore().collection(FirebaseCollection.chats)
}

// MARK: - Setup
extension Database {
    func setup(userID: UserID) async {
        addChatsListener(for: userID)
    }
}
