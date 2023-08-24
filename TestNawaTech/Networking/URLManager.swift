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
    var reference: String{
        switch self{
        case .getMotorcycles:
            return "Motorcycle"
        case .getMotorcycle(let company, let type):
            return "Motorcycle/\(company + type)"
        }
    }
    
    var type: FirestoreType{
        switch self {
        case .getMotorcycles:
            return .collection
        case .getMotorcycle:
            return .document
        }
    }
    
}
