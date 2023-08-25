//
//  Purchase.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import Foundation

class Purchase: Codable{
    var buyerId: String?
    var motorcycleId: String?
    var date: String?
    var total: Int?
    
    init(buyerId: String? = nil, motorcycleId: String? = nil, date: String? = nil, total: Int? = nil) {
        self.buyerId = buyerId
        self.motorcycleId = motorcycleId
        self.date = date
        self.total = total
    }
}
