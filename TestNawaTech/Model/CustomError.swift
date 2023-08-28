//
//  CustomError.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation

enum CustomError: Error{
    case callApiFailBecauseURLNotFound
    case apiReturnNoData
    case somethingWentWrong
    case fetchFromCoreDataError
    case failedToLoadJson
    case dataAlreadyExist
    case failedToSignIn(String)
    case failedToSignUp(String)
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .dataAlreadyExist:
            return NSLocalizedString("Data already exist", comment: "Display this eror when user already have saved that category previously")
        case .failedToSignUp(localizedDescription):
            return localizedDescription
        default:
            return NSLocalizedString("Something went wrong", comment: "Something unexpected occured")

        }
    }
}
