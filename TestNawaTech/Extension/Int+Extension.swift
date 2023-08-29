//
//  Int+Extension.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 29/08/23.
//

import Foundation

extension Int{
    func getValueInCurrency(abr: FinanceAbbreviation) -> String{
        var double = Double(self)
        print(double)
        switch abr{
        case .thousand:
            double /= 1000
        case .million:
            double /= 1000000
        case .none:
            break
        }
        let numberString = String(double)
        let firstThreeDigits = String(numberString.prefix(3))
        return "\(firstThreeDigits) \(abr.abr)"
    }
}

enum FinanceAbbreviation{
    case thousand
    case million
    case none
    
    var abr: String{
        switch self{
        case .thousand:
            return "K"
        case .million:
            return "M"
        case .none:
            return ""
        }
    }
}
