//
//  MessageContent.swift
//  Ohana
//
//  Created by Mu Yu on 10/22/22.
//

import Foundation

enum MessageContent: Codable {
    case text(_ text: TextMessageContent)
    case image(_ image: ImageMessageContent)
    case sticker(_ sticker: StickerMessageContent)
}


struct TextMessageContent: Codable {
    let text: String
}

struct ImageMessageContent: Codable {
    let imageStoragePath: String
    let thumbnailStoragePath: String
    let caption: String?
    let width: Int
    let height: Int
    let format: String
}

struct StickerMessageContent: Codable {
    let imageStoragePath: String
    let caption: String?
    let format: String
}
