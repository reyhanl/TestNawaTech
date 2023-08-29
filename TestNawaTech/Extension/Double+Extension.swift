//
//  Double+Extension.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 29/08/23.
//

import Foundation

extension Double{
    func getValueInCurrency(abr: FinanceAbbreviation) -> String{
        var temp = self
        switch abr{
        case .thousand:
            temp /= 1000
        case .million:
            temp /= 1000000
        case .none:
            break
        }
        let firstThreeDigits = String("\(temp)".prefix(4))
        return "\(firstThreeDigits) \(abr.abr)"
    }
    
    func giveAutoFinanceAbbreviations() -> String{
        var temp = self
        var abrTemp: FinanceAbbreviation = .none
        if self / 1000000 >= 1{
            abrTemp = .million
            temp /= 1000000
        }else if self / 1000 >= 1{
            abrTemp = .thousand
            temp /= 1000
        }else{
            abrTemp = .none
        }
        let firstThreeDigits = String("\(temp)".prefix(4))
        return "\(firstThreeDigits) \(abrTemp.abr)"
    }
}
