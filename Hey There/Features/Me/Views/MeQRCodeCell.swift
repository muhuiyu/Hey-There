//
//  MeQRCodeCell.swift
//  Hey There
//
//  Created by Mu Yu on 1/11/23.
//

import UIKit

class MeQRCodeCell: UITableViewCell {
    static let reuseID = NSStringFromClass(MeQRCodeCell.self)
    
    private let qrCodeImageView = UIImageView()
    
    var memberID: String? {
        didSet {
            if let memberID = memberID {
                qrCodeImageView.image = QRCodeHelper.generateQRCode(from: memberID)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - View Config
extension MeQRCodeCell {
    private func configureViews() {
        qrCodeImageView.contentMode = .scaleAspectFit
        contentView.addSubview(qrCodeImageView)
    }
    private func configureConstraints() {
        qrCodeImageView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(300)
            make.top.bottom.equalTo(contentView.layoutMarginsGuide).inset(Constants.Spacing.small)
        }
    }
}
