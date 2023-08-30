//
//  Setting.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 28/08/23.
//

import UIKit

enum Setting{
    case signOut
    case statistic
    case topUp
    
    var name: String{
        switch self{
        case .signOut:
            return "Sign out"
        case .statistic:
            return "Order history"
        case .topUp:
            return "Top up"
        }
    }
    
    var imageName: String{
        switch self{
        case .signOut:
            return "door.left.hand.open"
        case .statistic:
            return "chart.bar"
        case .topUp:
            return "creditcard"
        }
    }
    
    var tintColor: UIColor{
        switch self{
        case .signOut:
            return .red
        default:
            return .primaryForegroundColor
        }
    }
}
