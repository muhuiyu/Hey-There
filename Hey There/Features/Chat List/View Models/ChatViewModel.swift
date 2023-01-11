//
//  ChatViewModel.swift
//  Ohana
//
//  Created by Mu Yu on 10/16/22.
//

import UIKit
import RxSwift
import RxRelay

class ChatViewModel: BaseViewModel {
    
    // functions: search chats, start chat, delete chat
    private var chats: BehaviorRelay<[Chat]> = BehaviorRelay(value: [])
    private(set) var chatCells: BehaviorRelay<[UITableViewCell]> = BehaviorRelay(value: [])
        
    override func setup(appCoordinator: AppCoordinator?) {
        super.setup(appCoordinator: appCoordinator)
        configureSignals()
    }
}
// MARK: - Setup
extension ChatViewModel {
    private func configureSignals() {
        guard let appCoordinator = appCoordinator else { return }
        appCoordinator.dataProvider
            .chatsObserver
            .subscribe { chatDictionary in
                let chatsData = chatDictionary.map({ $1 })
                self.chats.accept(chatsData)
            }
            .disposed(by: disposeBag)
        
        self.chats
            .asObservable()
            .subscribe { _ in
                Task {
                    await self.reconfigureChatCells()
                }
            }
            .disposed(by: disposeBag)
    }
}
// MARK: - API request and ChatCells
extension ChatViewModel {
    func filterResults(with keyword: String) {
        // TODO: -
    }
    func deleteChat(for chat: Chat) {
        // TODO: -
    }
    func getChat(at indexPath: IndexPath) -> Chat? {
        return chats.value[indexPath.row]
    }
}
// MARK: - Internal Helpers
extension ChatViewModel{
    private func reconfigureChatCells() async {
        guard
            let appCoordinator = appCoordinator,
            !self.chats.value.isEmpty
        else { return }
        
        let userIDsToFetch = self.chats.value.reduce(into: Set<UserID>()) { partialResult, chat in
            chat.members.forEach { partialResult.insert($0) }
        }
        let cachedUsers = await appCoordinator.dataProvider
            .getUsers(for: Array(userIDsToFetch))
            .reduce(into: [UserID: AppUser](), { partialResult, user in
                partialResult[user.id] = user
            })
        await MainActor.run {
            reconfigureChatCellsContent(with: cachedUsers)
        }
    }
    private func reconfigureChatCellsContent(with cachedUsers: [UserID: AppUser]) {
        guard
            let appCoordinator = appCoordinator,
            let userID = appCoordinator.userManager.id
        else { return }
        
        let cells = self.chats.value.map { chat in
            let cell = ChatPreviewCell()
            
            if !chat.title.isEmpty {
                cell.nameString = chat.title
            } else {
                cell.nameString = chat.getUserNamesConcatenation(cachedUsers: cachedUsers,
                                                                 currentUserID: userID)
            }
            cell.messagePreviewString = chat.lastMessage?.previewString(currentUserID: userID)
            cell.timeString = chat.lastMessage?.sentTime.toTimeString(format: timeFormat)
            return cell
        }
        chatCells.accept(cells)
    }
}
// MARK: - Constants and strings
extension ChatViewModel {
    private var timeFormat: TimeFormat {
        return appCoordinator?.cacheManager.preferredTimeFormat ?? .civilian
    }
    var phoneIcon: UIImage? {
        return UIImage(systemName: Icons.phoneFill)
    }
    var titleString: String {
        return AppText.MainTab.chat
    }
}
