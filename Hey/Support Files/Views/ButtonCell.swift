//
//  ButtonCell.swift
//  Get Fit
//
//  Created by Mu Yu on 8/23/22.
//

import UIKit

class ButtonCell: UITableViewCell {
    static let reuseID = NSStringFromClass(ButtonCell.self)
    
    var title: String? {
        didSet {
            textLabel?.text = title
        }
    }
    var tapHandler: (() -> Void)?
    
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
extension ButtonCell {
    @objc
    private func didTapInView(_ sender: UITapGestureRecognizer) {
        self.tapHandler?()
    }
}

// MARK: - View Config
extension ButtonCell {
    private func configureViews() {
        textLabel?.textColor = UIColor.Brand.primary
    }
    private func configureConstraints() {
        
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView(_:)))
        addGestureRecognizer(tapRecognizer)
    }
    private func configureSignals() {
        
    }
}
