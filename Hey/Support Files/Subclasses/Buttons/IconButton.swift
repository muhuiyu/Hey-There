//
//  IconButton.swift
//  Tonari
//
//  Created by Mu Yu on 8/1/21.
//

import UIKit

class IconButton: UIView {
    
    private let iconImageView = UIImageView()
    private let containerView = UIView()
    
    var icon: UIImage? {
        get { return iconImageView.image }
        set { iconImageView.image = newValue }
    }
    var iconColor: UIColor? {
        didSet {
            iconImageView.tintColor = iconColor
        }
    }
    var iconSize: CGFloat = Constants.IconButtonSize.medium {
        didSet {
            containerView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
                make.size.equalTo(iconSize)
            }
        }
    }
    var tapHandler: (() -> Void)?
    // button size?
    
    init(frame: CGRect = .zero, icon: UIImage?) {
        super.init(frame: frame)
        self.icon = icon
        configureViews()
        configureConstraints()
        configureGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Actions
extension IconButton {
    @objc
    private func didTapButton() {
        tapHandler?()
    }
}
// MARK: - View Config
extension IconButton {
    private func configureViews() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = icon
        iconImageView.sizeToFit()
        containerView.addSubview(iconImageView)
        
        containerView.backgroundColor = .clear
        addSubview(containerView)
    }
    private func configureConstraints() {
        iconImageView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
        containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(iconSize)
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        addGestureRecognizer(tapRecognizer)
    }
}
