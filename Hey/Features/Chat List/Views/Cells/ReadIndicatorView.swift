//
//  ReadIndicatorView.swift
//  Ohana
//
//  Created by Mu Yu on 11/6/22.
//

import UIKit

class ReadIndicatorView: UIView {
    private let textLabel = UILabel()
    
    enum Status {
        case sent
        case delivered
        case read
        case error
    }
    var status: Status = .sent {
        didSet {
            switch status {
                // TODO: - change to icons
            case .sent: textLabel.text = "sent"
            case .delivered: textLabel.text = "delivered"
            case .read: textLabel.text = "read"
            case .error: textLabel.text = "error"
            }
        }
    }

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
extension ReadIndicatorView {
    private func configureViews() {
        textLabel.font = UIFont.desc
        textLabel.textAlignment = .right
        addSubview(textLabel)
    }
    private func configureConstraints() {
        textLabel.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func configureGestures() {
        // TODO: - ?
    }
}

