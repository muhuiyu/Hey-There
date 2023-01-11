//
//  DataProvider.swift
//  Ohana
//
//  Created by Mu Yu on 10/22/22.
//

import Foundation

protocol DataProvider: AnyObject {
    // Setup
    func setup() async
    
    // Auth
    func login() async
    func register() async
    func logout() async
    
    // Restore data, set data
}
