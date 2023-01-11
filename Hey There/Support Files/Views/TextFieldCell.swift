//
//  TextFieldCell.swift
//  Get Fit
//
//  Created by Mu Yu on 8/23/22.
//

import UIKit

class TextFieldCell: UITableViewCell {
    static let reuseID = NSStringFromClass(TextFieldCell.self)
    
    var textField = UITextField()
    
    var value: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    var valueChangedHandler: (() -> Void)?
    
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
// MARK: - Handlers
extension TextFieldCell {
    @objc
    private func didChangeValue(_ sender: UITextField) {
        valueChangedHandler?()
    }
}
// MARK: - View Config
extension TextFieldCell {
    private func configureViews() {
        textField.addTarget(self, action: #selector(didChangeValue(_ :)), for: .valueChanged)
        contentView.addSubview(textField)
    }
    private func configureConstraints() {
        textField.snp.remakeConstraints { make in
            make.edges.equalTo(contentView.layoutMarginsGuide)
        }
    }
    private func configureGestures() {
        
    }
    private func configureSignals() {
        
    }
}
