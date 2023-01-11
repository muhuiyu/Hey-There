//
//  MessageCellProtocol.swift
//  Ohana
//
//  Created by Mu Yu on 11/7/22.
//

import UIKit

protocol MessageCellDelegate: AnyObject {
    func MessageCellDidTapInView(_ cell: UITableViewCell, messageID: MessageID)
    func MessageCellDidLongPressInView(_ cell: UITableViewCell, messageID: MessageID)
}
