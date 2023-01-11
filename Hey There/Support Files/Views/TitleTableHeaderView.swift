//
//  TitleTableHeaderView.swift
//  Get Fit
//
//  Created by Mu Yu on 9/12/22.
//

import UIKit

class TitleTableHeaderView: UIView {
    private let nameLabel = UILabel()
    
    var title: String? {
        didSet {
            nameLabel.text = title
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - View Config
extension TitleTableHeaderView {
    private func configureViews() {
        nameLabel.font = UIFont.bodyHeavy
        nameLabel.textColor = .label
        nameLabel.textAlignment = .left
        addSubview(nameLabel)
        backgroundColor = .secondarySystemBackground
    }
    private func configureConstraints() {
        nameLabel.snp.remakeConstraints { make in
            make.leading.equalTo(layoutMarginsGuide).inset(Constants.Spacing.small)
            make.top.bottom.equalTo(layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
    }
}

