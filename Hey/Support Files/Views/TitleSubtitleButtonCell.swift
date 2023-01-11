//
//  TitleSubtitleButtonCell.swift
//  Get Fit
//
//  Created by Mu Yu on 9/10/22.
//

import UIKit

class TitleSubtitleButtonCell: UITableViewCell {
    static let reuseID = NSStringFromClass(TitleSubtitleButtonCell.self)
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let cellTappingArea = UIView()
    private let iconButton = IconButton(icon: UIImage(systemName: Icons.questionmark))
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    var icon: UIImage? {
        didSet {
            iconButton.icon = icon
        }
    }
    var tapHandler: (() -> Void)?
    var buttonTapHandler: (() -> Void)? {
        didSet {
            iconButton.tapHandler = buttonTapHandler
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
        configureGestures()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Handlers
extension TitleSubtitleButtonCell {
    @objc
    private func didTapInView(_ sender: UITapGestureRecognizer) {
        tapHandler?()
    }
}

// MARK: - View Config
extension TitleSubtitleButtonCell {
    private func configureViews() {
        titleLabel.text = "title"
        titleLabel.font = UIFont.body
        titleLabel.textColor = .label
        titleLabel.textAlignment = .left
        contentView.addSubview(titleLabel)
        
        subtitleLabel.text = "subtitle"
        subtitleLabel.font = UIFont.body
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .left
        contentView.addSubview(subtitleLabel)
        
        iconButton.contentMode = .scaleAspectFit
        iconButton.iconColor = UIColor.Brand.primary
        contentView.addSubview(iconButton)
    }
    private func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.leading.equalTo(contentView.layoutMarginsGuide)
            make.trailing.lessThanOrEqualTo(iconButton.snp.leading)
        }
        subtitleLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Spacing.trivial)
            make.trailing.lessThanOrEqualTo(iconButton.snp.leading)
            make.leading.bottom.equalTo(contentView.layoutMarginsGuide)
        }
        iconButton.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(contentView.layoutMarginsGuide).inset(Constants.Spacing.trivial)
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView(_:)))
        addGestureRecognizer(tapRecognizer)
    }
}


