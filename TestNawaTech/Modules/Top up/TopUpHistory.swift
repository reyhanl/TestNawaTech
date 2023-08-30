//
//  TopUpHistory.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 30/08/23.
//

import Foundation

class TopUpHistory: Codable{
    var userId: String?
    var topUp: String?
    var date: String?
    var id: String?
    
    init(userId: String? = nil, topUp: String? = nil, date: String? = nil, id: String? = nil) {
        self.userId = userId
        self.topUp = topUp
        self.date = date
        self.id = id
    }
}
