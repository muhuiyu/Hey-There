//
//  ChatroomInputBarView.swift
//  Ohana
//
//  Created by Mu Yu on 11/7/22.
//

import UIKit

protocol ChatroomInputBarViewDelegate: AnyObject {
    func chatroomInputBarViewDidTapMoreButton(_ view: ChatroomInputBarView)
    func chatroomInputBarView(_ view: ChatroomInputBarView, didSend text: String)
    func chatroomInputBarViewDidTapAudioButton(_ view: ChatroomInputBarView)
}

class ChatroomInputBarView: UIView {
    
    private let moreButton = IconButton(icon: UIImage(systemName: Icons.plus))
    private let textField = UITextField()
    private let actionButton = IconButton(icon: UIImage(systemName: Icons.micFill))
    
    weak var delegate: ChatroomInputBarViewDelegate?
    
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
// MARK: - Handlers
extension ChatroomInputBarView {
    private func didTapInMoreButton() {
        delegate?.chatroomInputBarViewDidTapMoreButton(self)
    }
    private func didTapActionButton() {
        if !isTextFieldEmpty, let text = textField.text {
            delegate?.chatroomInputBarView(self, didSend: text)
        } else {
            delegate?.chatroomInputBarViewDidTapAudioButton(self)
        }
    }
}
// MARK: - View Config
extension ChatroomInputBarView {
    private func configureViews() {
        moreButton.tintColor = UIColor.Brand.primary
        moreButton.tapHandler = { [weak self] in
            self?.didTapInMoreButton()
        }
        addSubview(moreButton)
        
        textField.layer.cornerRadius = 16
        textField.backgroundColor = UIColor.systemBackground
        textField.delegate = self
        addSubview(textField)
        
        actionButton.tintColor = UIColor.Brand.primary
        actionButton.tapHandler = { [weak self] in
            self?.didTapActionButton()
        }
        addSubview(actionButton)
    }
    private func configureConstraints() {
        moreButton.snp.remakeConstraints { make in
            make.leading.equalTo(layoutMarginsGuide)
            make.centerY.equalToSuperview()
            make.size.equalTo(Constants.IconButtonSize.small)
        }
        textField.snp.remakeConstraints { make in
            make.top.bottom.equalTo(layoutMarginsGuide)
            make.leading.equalTo(moreButton.snp.trailing).offset(Constants.Spacing.small)
            make.trailing.equalTo(actionButton.snp.leading).offset(-Constants.Spacing.small)
        }
        actionButton.snp.remakeConstraints { make in
            make.size.equalTo(Constants.IconButtonSize.small)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(layoutMarginsGuide)
        }
    }
    private func configureGestures() {
        
    }
}
// MARK: - Delegate
extension ChatroomInputBarView: UITextFieldDelegate {
    private var isTextFieldEmpty: Bool {
        if let text = textField.text, !text.isEmpty {
            return false
        } else {
            return true
        }
    }
    private func configureActionButton() {
        actionButton.icon = isTextFieldEmpty ? UIImage(systemName: Icons.micFill) : UIImage(systemName: Icons.chevronForward)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        configureActionButton()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        configureActionButton()
    }
}
