//
//  Message.swift
//  Ohana
//
//  Created by Mu Yu on 10/22/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

typealias MessageID = String
typealias MessageList = SortedArray<Message>

struct Message {
    let id: MessageID
    let sender: UserID
    let type: MessageType
    let content: MessageContent
    let searchableContent: String?
    let quotedMessageId: String?
    let sentTime: Date
}

extension Message {
    func isSentByMe(currentUserID: UserID) -> Bool {
        return sender == currentUserID
    }
    func previewString(currentUserID: UserID) -> String {
        if isSentByMe(currentUserID: currentUserID) {
            return "You: " + messageContentPreviewString
        } else {
            return messageContentPreviewString
        }
    }
    private var messageContentPreviewString: String {
        switch content {
        case .text(let content):
            return content.text
        case .image(_):
            return "[image]"
        case .sticker(_):
            return "[sticker]"
        }
    }
}

// Sorted by sentTime
extension Message: Comparable {
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentTime < rhs.sentTime
    }
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentTime == rhs.sentTime
    }
}

extension Message: Codable {
    private struct MessageData: Codable {
        let sender: UserID
        let type: MessageType
        let content: MessageContent
        let searchableContent: String?
        let quotedMessageId: String?
        let sentTime: Date
        
        private enum CodingKeys: String, CodingKey {
            case sender
            case type
            case content
            case searchableContent
            case quotedMessageId
            case sentTime
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.sender = try container.decode(String.self, forKey: .sender)
            self.type = try container.decode(MessageType.self, forKey: .type)
            
            switch self.type {
            case .image:
                self.content = .image(try container.decode(ImageMessageContent.self, forKey: .content))
            case .text:
                self.content = .text(try container.decode(TextMessageContent.self, forKey: .content))
            case .sticker:
                self.content = .sticker(try container.decode(StickerMessageContent.self, forKey: .content))
            }
            
            self.searchableContent = try container.decode(String.self, forKey: .searchableContent)
            self.quotedMessageId = try container.decode(String.self, forKey: .quotedMessageId)
            self.sentTime = try container.decode(Date.self, forKey: .sentTime)
        }
        
        func encode(to encoder: Encoder) throws {
            let container = encoder.container(keyedBy: CodingKeys.self)
            
        }
    }
    init(snapshot: DocumentSnapshot) throws {
        self.id = snapshot.documentID
        let data = try snapshot.data(as: MessageData.self)
        self.sender = data.sender
        self.type = data.type
        self.content = data.content
        self.searchableContent = data.searchableContent
        self.quotedMessageId = data.quotedMessageId
        self.sentTime = data.sentTime
    }
}
