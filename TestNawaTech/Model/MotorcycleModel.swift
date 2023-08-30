//
//  MotorCycle.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation

struct MotorcycleModel: Codable{
    var name: String?
    var company: String?
    var price: Double?
    var currency: String?
    var imageUrl: String?
    var description: String?
    var thumbImageUrl: String?
    var id: String?
    
    init(name: String? = nil, company: String? = nil, price: Double? = nil, currency: String? = nil, imageUrl: String? = nil, description: String? = nil, thumbImageUrl: String? = nil, id: String? = nil) {
        self.name = name
        self.company = company
        self.price = price
        self.currency = currency
        self.imageUrl = imageUrl
        self.description = description
        self.thumbImageUrl = thumbImageUrl
        self.id = id
    }
}
