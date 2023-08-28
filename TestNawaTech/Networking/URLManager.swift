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
    case getMotorcycles
    case getMotorcycle(String, String)
    case users
    case user(String)
    case purchase
    case custom(String, FirestoreType)
    
    var reference: String{
        switch self{
        case .getMotorcycles:
            return "Motorcycle"
        case .getMotorcycle(let company, let type):
            return "Motorcycle/\(company + type)"
        case .purchase:
            return "purchase/"
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
        case .getMotorcycles:
            return .collection
        case .getMotorcycle:
            return .document
        case .purchase:
            return .collection
        case .custom(_, let type):
            return type
        case .users:
            return .collection
        case .user(_):
            return .document
        }
    }
    
}
