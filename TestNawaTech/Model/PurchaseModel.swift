//
//  Purchase.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import Foundation

class PurchaseModel: Codable{
    var buyerId: String?
    var motorcycleId: String?
    var date: String?
    var total: Double?
    var status: String?
    var transactionId: String?
    var enumStatus: PurchaseStatus?{
        return PurchaseStatus(rawValue: status ?? "")
    }
    var motorCycle: MotorcycleModel?
    
    init(buyerId: String? = nil, motorcycleId: String? = nil, date: String? = nil, total: Double? = nil, status: String? = nil, transactionId: String? = nil) {
        self.buyerId = buyerId
        self.motorcycleId = motorcycleId
        self.date = date
        self.total = total
        self.status = status
        self.transactionId = transactionId
    }
    
    private enum CodingKeys: String, CodingKey {
        case buyerId
        case motorcycleId
        case date
        case total
        case status
        case transactionId
    }
}

enum PurchaseStatus: String{
    case waitingForConfirmation = "waitingForConfirmation"
    case cancelled = "cancelled"
    case finished = "finished"
    
    var text: String{
        switch self{
        case .waitingForConfirmation:
            return "Waiting for seller"
        case .cancelled:
            return "Cancelled"
        case .finished:
            return "Order completed"
        }
    }
}
