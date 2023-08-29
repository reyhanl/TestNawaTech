//
//  URLManager.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation
import FirebaseFirestore

enum FirestoreType{
    case document
    case collection
}

enum FirestoreReferenceType{
    case motorcycles
    case motorcycle(String)
    case users
    case user(String)
    case purchases
    case purchase(String)
    case custom(String, FirestoreType)
    
    var reference: String{
        switch self{
        case .motorcycles:
            return "motorcycles/"
        case .motorcycle(let id):
            return "motorcycles/\(id)"
        case .purchases:
            return "purchases/"
        case .purchase(let id):
            return "purchases/\(id)"
        case .custom(let reference, _):
            return reference
        case .users:
            return "users/"
        case .user(let id):
            return "users/\(id)"
        }
    }
    
    var type: FirestoreType{
        switch self {
        case .motorcycles:
            return .collection
        case .motorcycle:
            return .document
        case .purchases:
            return .collection
        case .custom(_, let type):
            return type
        case .users:
            return .collection
        case .user(_):
            return .document
        case .purchase(_):
            return .document
        }
    }
    
}

enum FirebaseStorageType{
    case profile(String)
    case motorcycle(String)
    
    var reference: String{
        switch self{
        case .profile(let id):
            return "profile/\(id)"
        case .motorcycle(let id):
            return "motorcycle/\(id)"
        }
    }
}
