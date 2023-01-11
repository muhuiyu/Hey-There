//
//  ChatCoordinator.swift
//  Ohana
//
//  Created by Mu Yu on 10/15/22.
//

import UIKit

class ChatCoordinator: BaseCoordinator {
    enum Destination {
        case viewChatroom(Chat)
        case startCall(Chat)
    }
}

// MARK: - ViewController List
extension ChatCoordinator {
    private func makeViewController(for destination: Destination) -> ViewController? {
        switch destination {
        case .viewChatroom(let chat):
            let viewController = ChatroomViewController(appCoordinator: self.parentCoordinator,
                                                        coordinator: self,
                                                        viewModel: ChatroomViewModel())
            viewController.viewModel.chat.accept(chat)
            return viewController
        case .startCall(let chat):
            // TODO: - add CallViewController
            return BaseViewController(appCoordinator: self.parentCoordinator, coordinator: self)
        }
    }
}

// MARK: - Navigation
extension ChatCoordinator {
    func showChatroom(for chat: Chat) {
        guard let viewController = makeViewController(for: .viewChatroom(chat)) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    func showCall(for chat: Chat) {
        guard let viewController = makeViewController(for: .startCall(chat)) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
}
