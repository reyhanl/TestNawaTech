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
    var status: String?
    var enumStatus: PurchaseStatus?{
        return PurchaseStatus(rawValue: status ?? "")
    }
    
    init(buyerId: String? = nil, motorcycleId: String? = nil, date: String? = nil, total: Int? = nil, status: String? = nil) {
        self.buyerId = buyerId
        self.motorcycleId = motorcycleId
        self.date = date
        self.total = total
        self.status = status
    }
}

enum PurchaseStatus: String{
    case waitingForConfirmation = "waitingForConfirmation"
    case cancelled = "cancelled"
    case finished = "finished"
}
