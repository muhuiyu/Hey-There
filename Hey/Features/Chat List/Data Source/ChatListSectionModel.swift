//
//  ChatListSectionModel.swift
//  Ohana
//
//  Created by Mu Yu on 12/30/22.
//

import UIKit
import RxDataSources

typealias ChatListSectionModel = SectionModel<ChatListSection, ChatListItem>

enum ChatListSection {
    case account
    case common

    var headerHeight: CGFloat {
        return 40.0
    }

    var footerHeight: CGFloat {
        return 1.0
    }
}

enum ChatListItem {
    
    // account section
    case account
    case security
    case notification
    case contents
    // common section
    case sounds
    case dataUsing
    case accessibility

    // other
    case description(text: String)

    var title: String? {
        switch self {
        case .account:
            return "アカウント"
        case .security:
            return "セキュリティ"
        case .notification:
            return "通知"
        case .contents:
            return "コンテンツ設定"
        case .sounds:
            return "サウンド設定"
        case .dataUsing:
            return "データ利用時の設定"
        case .accessibility:
            return "アクセシビリティ"
        case .description:
            return nil
        }
    }

    var rowHeight: CGFloat {
        switch self {
        case .description:
            return 72.0
        default:
            return 48.0
        }
    }

    var accessoryType: UITableViewCell.AccessoryType {
        switch self {
        case .account, .security, .notification, .contents, .sounds, .dataUsing, .accessibility:
            return .disclosureIndicator
        case .description:
            return .none
        }
    }
}
