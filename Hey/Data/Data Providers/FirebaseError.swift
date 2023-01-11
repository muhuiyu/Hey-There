//
//  FirebaseError.swift
//  Ohana
//
//  Created by Mu Yu on 10/22/22.
//

import Foundation

enum FirebaseError: Error {
    // firestore
    case snapshotMissing
    case multipleDocumentUsingSameID
    case dataKeyMissing
    case entryInitFailure
    case userMissing
    case documentMissing
    case invalidDocumentID
    case invalidQuery
    case setDataFailure
    
    // auth
    case missingClientID
    case missingToken
}
