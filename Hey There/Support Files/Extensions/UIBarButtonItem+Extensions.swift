//
//  UIBarButtonItem+Extensions.swift
//  Ohana
//
//  Created by Mu Yu on 12/29/22.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    static func makeSettingsButton(target: Any?, action: Selector?) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(systemName: Icons.gearshape),
                               style: .plain,
                               target: target,
                               action: action)
    }
    
    static func makePhoneButton(target: Any?, action: Selector?) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(systemName: Icons.phoneFill),
                               style: .plain,
                               target: target,
                               action: action)
    }
    
    static func makeNotificationButton(target: Any?, action: Selector?) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(systemName: Icons.bellbadgeFill),
                               style: .plain,
                               target: target,
                               action: action)
    }
    
    static func makeAddButton(target: Any?, action: Selector?) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(systemName: Icons.plus),
                               style: .plain,
                               target: target,
                               action: action)
    }
}
