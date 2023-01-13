//
//  WelcomeLoadingViewController.swift
//  Hey There
//
//  Created by Mu Yu on 1/11/23.
//

import UIKit
import Lottie

class LoadingScreenViewController: BaseViewController {
    
    private let titleLabel = UILabel()
    private let animationView = LottieAnimationView(name: "loading")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
    }
}
// MARK: - View Config
extension LoadingScreenViewController {
    private func configureViews() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        view.addSubview(animationView)
        animationView.play()
        
        titleLabel.font = UIFont.h2
        titleLabel.text = AppText.Loading.title
        view.addSubview(titleLabel)
    }
    private func configureConstraints() {
//        titleLabel.snp.remakeConstraints { make in
//            make.center.equalToSuperview()
//        }
        animationView.snp.remakeConstraints { make in
            make.size.equalTo(200)
            make.center.equalToSuperview()
        }
    }
    private func configureGestures() {
        
    }
    private func configureSignals() {
        
    }
}

// MARK: -
extension LoadingScreenViewController {

}
