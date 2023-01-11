//
//  SpinnerView.swift
//  JLPT quiz practice MVVM
//
//  Created by Mu Yu on 5/4/22.
//

import Foundation
import UIKit

class SpinnerView: UIView {
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureViews()
        configureGestures()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - View Config
extension SpinnerView {
    private func configureViews() {
        backgroundColor = .clear
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        addSubview(spinner)
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        spinner.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
}
