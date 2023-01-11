//
//  ErrorHandler.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/3/22.
//

import Foundation
import UIKit

class ErrorHandler {
    static let shared = ErrorHandler()
}

extension ErrorHandler {
    func handle(_ error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

enum AppError: Error {
    case missingRootViewController
}
