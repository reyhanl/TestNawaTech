//
//  Profile.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 28/08/23.
//

import Foundation

class Profile: Codable{
    var name: String?
    var id: String?
    var profilePictureUrl: String?
    var balance: Double?
    
    init(name: String? = nil, id: String? = nil, profilePictureUrl: String? = nil, balance: Double? = nil) {
        self.name = name
        self.id = id
        self.profilePictureUrl = profilePictureUrl
        self.balance = balance
    }
}
