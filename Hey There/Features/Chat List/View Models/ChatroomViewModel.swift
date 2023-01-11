//
//  ChatroomViewModel.swift
//  Ohana
//
//  Created by Mu Yu on 11/6/22.
//

import Foundation

import UIKit
import RxSwift
import RxRelay

// functions: send and receive messages, phone call, search messages, save messages
class ChatroomViewModel: BaseViewModel {
    
    var chatID: BehaviorRelay<ChatID?> = BehaviorRelay(value: nil)
    
    private(set) var chat: BehaviorRelay<Chat?> = BehaviorRelay(value: nil)
    private(set) var messages: BehaviorRelay<MessageList> = BehaviorRelay(value: MessageList())
    
    // Display content
    var chatroomNameString: BehaviorRelay<String> = BehaviorRelay(value: "")
//    private var searchResults = [Session]()
//    var displayingResults: BehaviorRelay<[Session]> = BehaviorRelay(value: [])
    
    override func setup(appCoordinator: AppCoordinator?) {
        super.setup(appCoordinator: appCoordinator)
        configureSignals()
    }
}
// MARK: - Setup
extension ChatroomViewModel {
    private func configureSignals() {
        chat.asObservable()
            .subscribe { _ in
                Task {
                    await self.configureChatroomNameString()
                }
            }
            .disposed(by: disposeBag)
    }
}
// MARK: - API request
extension ChatroomViewModel {
    func getChatAndMessages() async {
        guard
            let appCoordinator = appCoordinator,
            let chatID = chatID.value
        else { return }
        
        let chatResult = await appCoordinator.dataProvider.getChat(for: chatID)
        chat.accept(chatResult)
        
        let messagesResult = await appCoordinator.dataProvider.getMessages(for: chatID)
        messages.accept(SortedArray(unsorted: messagesResult))
    }
    func getMessage(at indexPath: IndexPath) -> Message? {
        return messages.value[indexPath.row]
    }
    func getMessage(for messageID: MessageID) -> Message? {
        return messages.value.first(where: { $0.id == messageID })
    }
    var currentUserID: UserID? {
        return appCoordinator?.userManager.id
    }
}
// MARK: - Constants and strings
extension ChatroomViewModel {
    var phoneIcon: UIImage? {
        return UIImage(systemName: Icons.phoneFill)
    }
    var searchIcon: UIImage? {
        return UIImage(systemName: Icons.magnifyingglass)
    }
}
// MARK: - Internal helpers
extension ChatroomViewModel {
    private func configureChatroomNameString() async {
        guard let chat = chat.value else { return }
        
        if !chat.title.isEmpty {
            chatroomNameString.accept(chat.title)
        } else {
            guard
                let appCoordinator = appCoordinator,
                let userID = appCoordinator.userManager.id
            else { return }
            
            var cachedUsers = [UserID: AppUser]()
            await appCoordinator.dataProvider.getUsers(for: Array(chat.members)).forEach({ cachedUsers[$0.id] = $0 })
            let name = chat.getUserNamesConcatenation(cachedUsers: cachedUsers, currentUserID: userID)
            chatroomNameString.accept(name)
        }
    }
}
// MARK: - Search messages
extension ChatroomViewModel {
//    private var isFiltering: Bool {
//
//    }
//    private func clearFilters() {
//        filterConfiguration = nil
//        displayingResults.accept(searchResults)
//    }
}

// MARK: - Styles
extension ChatroomViewModel {
    enum UserType {
        case sender
        case receiver
    }
    struct Colors {
        static func messageBubble(for type: UserType) -> UIColor {
            switch type {
            case .sender: return .systemBlue
            case .receiver: return .systemGray3
            }
        }
        static func messageText(for type: UserType) -> UIColor {
            switch type {
            case .sender: return .white
            case .receiver: return .black
            }
        }
        static var messageTime: UIColor { return .secondaryLabel }
    }
    struct Constants {
        static let messageBubbleCornerRaduis: CGFloat = 12
    }
}
