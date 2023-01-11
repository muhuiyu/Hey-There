//
//  KeychainHelper.swift
//  Ohana
//
//  Created by Mu Yu on 10/15/22.
//

import Foundation

final class KeychainHelper {
    static let standard = KeychainHelper()
    
    static let kAuthAccount = "evolve-api"
    static let kAccessToken = "access-token"
    
    private init() {}
    
    enum KeychainError: Error {
        case itemNotFound
        case unexpectedItemData
        case unhandledError(status: OSStatus)
    }
}

extension KeychainHelper {
    func save(_ data: Data, service: String, account: String) throws {
        let query = [
           kSecValueData: data,
           kSecAttrService: service,
           kSecAttrAccount: account,
           kSecClass: kSecClassGenericPassword
        ] as CFDictionary

        let status = SecItemAdd(query, nil)

        switch status {
        case errSecDuplicateItem:
            let status = updateKeychainItem(data, service: service, account: account)
            if status != errSecSuccess {
                throw KeychainError.unhandledError(status: status)
            }
        case errSecSuccess:
            return
        default:
            throw KeychainError.unhandledError(status: status)
        }
    }
    func read(service: String, account: String) throws -> Data? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        switch status {
        case errSecItemNotFound:
            return nil
        case errSecSuccess:
            guard let data = item as? Data else {
                throw KeychainError.unexpectedItemData
            }
            return data
        default:
            throw KeychainError.unhandledError(status: status)
        }
    }
        
    func delete(service: String, account: String) throws {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        let status = SecItemDelete(query)
        if status != errSecSuccess {
            throw KeychainError.unhandledError(status: status)
        }
    }
}
extension KeychainHelper {
    private func updateKeychainItem(_ data: Data, service: String, account: String) -> OSStatus {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        let attributesToUpdate = [kSecValueData: data] as CFDictionary
        
        let status = SecItemUpdate(query, attributesToUpdate)
        return status
    }
}


//extension KeychainHelper {
//
//    func save<T>(_ item: T, service: String, account: String) where T : Codable {
//
//        do {
//            // Encode as JSON data and save in keychain
//            let data = try JSONEncoder().encode(item)
//            save(data, service: service, account: account)
//
//        } catch {
//            assertionFailure("Fail to encode item for keychain: \(error)")
//        }
//    }
//
//    func read<T>(service: String, account: String, type: T.Type) -> T? where T : Codable {
//
//        // Read item data from keychain
//        guard let data = read(service: service, account: account) else {
//            return nil
//        }
//
//        // Decode JSON data to object
//        do {
//            let item = try JSONDecoder().decode(type, from: data)
//            return item
//        } catch {
//            assertionFailure("Fail to decode item for keychain: \(error)")
//            return nil
//        }
//    }
//
//}
