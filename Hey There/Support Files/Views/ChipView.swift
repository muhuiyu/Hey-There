//
//  ChipView.swift
//  Ohana
//
//  Created by Mu Yu on 10/17/22.
//

import UIKit

class ChipView: UIView {

    private let textLabel = UILabel()
    private let containerView = UIView()
    
    var text: String? {
        get { return textLabel.text }
        set { textLabel.text = newValue }
    }
    
    var textColor: UIColor = .label {
        didSet {
            reconfigureStyles()
        }
    }
    
    var selectedColor: UIColor = UIColor.Brand.primary {
        didSet {
            reconfigureStyles()
        }
    }
    
    var isSelected: Bool = false {
        didSet {
            reconfigureStyles()
        }
    }
    
    var tapHandler: (() -> Void)?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
        configureGestures()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - View Config
extension ChipView {
    @objc
    private func didTapInView() {
        tapHandler?()
    }
    private func reconfigureStyles() {
        if isSelected {
            textLabel.textColor = selectedColor
            textLabel.font = UIFont.smallBold
            containerView.layer.borderWidth = 2
            containerView.layer.borderColor = selectedColor.cgColor
            containerView.backgroundColor = selectedColor.withAlphaComponent(0.2)
        } else {
            textLabel.textColor = textColor
            textLabel.font = UIFont.small
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = UIColor.tertiaryLabel.cgColor
            containerView.backgroundColor = UIColor.systemBackground
        }
    }

    private func configureViews() {
        textLabel.textAlignment = .center
        containerView.addSubview(textLabel)
        containerView.layer.cornerRadius = 12
        addSubview(containerView)
    }
    private func configureConstraints() {
        textLabel.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.Spacing.small)
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.medium)
        }
        containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView))
        addGestureRecognizer(tapRecognizer)
    }
}

