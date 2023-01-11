//
//  MessageTextCell.swift
//  Ohana
//
//  Created by Mu Yu on 11/6/22.
//

import UIKit

class MessageTextCell: UITableViewCell {
    static let reuseID = NSStringFromClass(MessageTextCell.self)
    
    private let containerView = UIView()
    private let contentLabel = UILabel()
    private let detailStack = UIStackView()
    private let timeLabel = UILabel()
    private let readIndicatorView = ReadIndicatorView()
    
    private let messageID: MessageID
    private let content: TextMessageContent
    private let isSentByMe: Bool
    
    var readStatus: ReadIndicatorView.Status = .sent {
        didSet {
            readIndicatorView.status = readStatus
        }
    }
    
    weak var delegate: MessageCellDelegate?
    
    init(messageID: MessageID, with content: TextMessageContent, isSentByMe: Bool) {
        self.messageID = messageID
        self.content = content
        self.isSentByMe = isSentByMe
        super.init(style: .default, reuseIdentifier: nil)
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Handlers
extension MessageTextCell {
    @objc
    private func didTapInView() {
        delegate?.MessageCellDidTapInView(self, messageID: messageID)
    }
    @objc
    private func didLongPressInView() {
        delegate?.MessageCellDidLongPressInView(self, messageID: messageID)
    }
}

// MARK: - View Config
extension MessageTextCell {
    private func configureViews() {
        let userType = isSentByMe ? ChatroomViewModel.UserType.sender : ChatroomViewModel.UserType.receiver
        
        contentLabel.font = UIFont.body
        contentLabel.text = content.text
        contentLabel.textColor = ChatroomViewModel.Colors.messageText(for: userType)
        contentLabel.textAlignment = .left
        contentLabel.numberOfLines = 0
        containerView.addSubview(contentLabel)
        
        containerView.backgroundColor = ChatroomViewModel.Colors.messageBubble(for: userType)
        containerView.layer.cornerRadius = ChatroomViewModel.Constants.messageBubbleCornerRaduis
        contentView.addSubview(containerView)
        
        timeLabel.font = UIFont.desc
        timeLabel.textColor = ChatroomViewModel.Colors.messageTime
        timeLabel.textAlignment = .right
        // TODO: -
        timeLabel.text = "13:00"
        detailStack.addArrangedSubview(timeLabel)
        
        if userType == .sender {
            // TODO: - Set readIndicator status
            readIndicatorView.status = .sent
            detailStack.addArrangedSubview(readIndicatorView)
        }
        
        detailStack.axis = .horizontal
        detailStack.alignment = .bottom
        detailStack.spacing = Constants.Spacing.slight
        contentView.addSubview(detailStack)
    }
    private func configureConstraints() {
        contentLabel.snp.remakeConstraints { make in
            make.edges.equalTo(containerView.layoutMarginsGuide).inset(Constants.Spacing.trivial)
        }
        containerView.snp.remakeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide)
            if isSentByMe {
                make.top.trailing.equalTo(contentView.layoutMarginsGuide)
            } else {
                make.top.leading.equalTo(contentView.layoutMarginsGuide)
            }
        }
        detailStack.snp.remakeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(Constants.Spacing.trivial)
            make.trailing.equalTo(containerView)
            make.bottom.equalTo(contentView.layoutMarginsGuide).inset(Constants.Spacing.trivial)
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView))
        containerView.addGestureRecognizer(tapRecognizer)
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressInView))
        containerView.addGestureRecognizer(longPressRecognizer)
    }
    private func configureSignals() {
        
    }
}
