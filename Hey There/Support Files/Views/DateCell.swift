//
//  DateCell.swift
//  Get Fit
//
//  Created by Mu Yu on 8/23/22.
//

import Foundation
import UIKit

class DateCell: UITableViewCell {
    static let reuseID = NSStringFromClass(DateCell.self)
    
    private let titleLabel = UILabel()
    private let valueStack = UIStackView()
    private let datePicker = UIDatePicker()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var date: DateAndTime {
        get { return DateAndTime(date: datePicker.date) }
        set { datePicker.date = newValue.toDate() ?? Date() }
    }
    var endEditingHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.date = DateAndTime(date: Date.today)
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Selectors
extension DateCell {
    @objc
    private func didChangeValue(_ sender: UIDatePicker) {
        self.endEditingHandler?()
    }
}
// MARK: - View Config
extension DateCell {
    private func configureViews() {
        titleLabel.textAlignment = .left
        titleLabel.textColor = .label
        titleLabel.font = UIFont.body
        contentView.addSubview(titleLabel)
        
        datePicker.date = date.toDate() ?? Date()
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .compact
        datePicker.addTarget(self, action: #selector(didChangeValue(_:)), for: .editingDidEnd)
        contentView.addSubview(datePicker)
    }
    private func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.leading.bottom.equalTo(contentView.layoutMarginsGuide)
    }
        datePicker.snp.remakeConstraints { make in
            make.top.bottom.equalTo(titleLabel)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(titleLabel.snp.trailing).offset(Constants.Spacing.small)
        }
    }
    private func configureGestures() {
        
    }
    private func configureSignals() {
        
    }
}
