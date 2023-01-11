//
//  ChatPreviewCell.swift
//  Ohana
//
//  Created by Mu Yu on 11/6/22.
//

import UIKit

class ChatPreviewCell: UITableViewCell {
    static let reuseID = NSStringFromClass(ChatPreviewCell.self)
    
    private let avatarView = UIImageView()
    
    private let contentStack = UIStackView()
    private let nameLabel = UILabel()
    private let messagePreviewLabel = UILabel()
    
    private let timeStack = UIStackView()
    private let timeLabel = UILabel()
    private let readIndicatorView = UIImageView(image: UIImage(systemName: Icons.circleFill))
    
    var avatar: UIImage? {
        didSet {
            avatarView.image = avatar
        }
    }
    var nameString: String? {
        didSet {
            nameLabel.text = nameString
        }
    }
    var messagePreviewString: String? {
        didSet {
            messagePreviewLabel.text = messagePreviewString
        }
    }
    var timeString: String? {
        didSet {
            timeLabel.text = timeString
        }
    }
    // TODO: - read Status
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - View Config
extension ChatPreviewCell {
    private func reconfigureStyles() {
        nameLabel.textColor = .label
        messagePreviewLabel.textColor = .secondaryLabel
        timeLabel.textColor = .label
        // TODO: - add read status
//        readIndicatorView.isHidden = false
        backgroundColor = .systemBackground
    }
    private func configureViews() {
        // TODO: -
        avatarView.backgroundColor = .red
        avatarView.clipsToBounds = true
        avatarView.contentMode = .scaleAspectFill
        contentView.addSubview(avatarView)
        
        nameLabel.font = UIFont.bodyMedium
        nameLabel.textColor = .label
        contentStack.addArrangedSubview(nameLabel)
        messagePreviewLabel.font = UIFont.small
        messagePreviewLabel.textColor = .secondaryLabel
        contentStack.addArrangedSubview(messagePreviewLabel)
        contentStack.axis = .vertical
        contentStack.spacing = Constants.Spacing.trivial
        contentStack.alignment = .leading
        contentView.addSubview(contentStack)
        
        timeLabel.font = UIFont.small
        timeLabel.textColor = .label
        timeStack.addArrangedSubview(timeLabel)
        readIndicatorView.tintColor = UIColor.Brand.primary
        readIndicatorView.contentMode = .scaleAspectFit
        timeStack.addArrangedSubview(readIndicatorView)
        timeStack.axis = .vertical
        timeStack.spacing = Constants.Spacing.trivial
        timeStack.alignment = .trailing
        contentView.addSubview(timeStack)
    }
    private func configureConstraints() {
        readIndicatorView.snp.remakeConstraints { make in
            make.size.equalTo(12)
        }
        avatarView.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.size.equalTo(Constants.AvatarImageSize.medium)
            make.centerY.equalToSuperview()
        }
        contentStack.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(avatarView.snp.trailing).offset(Constants.Spacing.small)
        }
        timeStack.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentStack)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(contentStack.snp.trailing).offset(Constants.Spacing.small)
            make.width.equalTo(100)
        }
    }
    private func configureGestures() {
        
    }
    private func configureSignals() {
        
    }
}

