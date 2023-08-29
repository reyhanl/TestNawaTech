//
//  HistoryInteractor.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 29/08/23.
//

import FirebaseAuth
import FirebaseFirestore

class HistoryInteractor: HistoryPresenterToInteractorProtocol{
    
    var presenter: HistoryInteractorToPresenterProtocol?
    
    func fetchHistory() {
        guard let id = UserDefaultHelper.shared.getProfile()?.id
        else{
            presenter?.result(result: .failure(CustomError.somethingWentWrong))
            return
        }
        let predicate = NSPredicate(format: "buyerId == %@", id)
        NetworkManager.shared.fetchCollection(reference: .purchases, where: predicate) { [weak self] (result: Result<[Purchase], Error>) in
            guard let self = self else{return}
            switch result{
            case .success(let purchases):
                self.presenter?.result(result: .success(.successfullyFetchedHistory(purchases)))
            case .failure(let error):
                self.presenter?.result(result: .failure(error))
            }
        }
    }
    
    func getChartData(purchases: [Purchase]){
        let currentMonth = Date().get(.month, calendar: .current)
        let from = currentMonth < 6 ? 1:currentMonth - 5
        var monthNames: [String] = []
        var numbers: [CGFloat] = []
        for index in from...currentMonth{
            let firstThreeLetter = NSString(string: Date.monthsName[index - 1]).substring(with: .init(location: 0, length: 3))
            monthNames.append(firstThreeLetter)
            let thisMonthPurchase = getThisMonthPurchases(purchases: purchases, currentMonth: index)
            let totalSpending = thisMonthPurchase.reduce(0) {$0 + ($1.total ?? 0)}
            numbers.append(CGFloat(totalSpending))
        }
        presenter?.result(result: .success(.successfullyFetchedChartData((monthNames, numbers))))
    }
    
    func getThisMonthPurchases(purchases: [Purchase], currentMonth: Int) -> [Purchase]{
        return purchases.filter({ purchase in
            guard purchase.enumStatus == .finished else{return false}
            guard let date = purchase.date?.getDate(format: Date.defaultDateFormat) else{return false}
            return date.get(.month, calendar: .current) == currentMonth
        })
    }
}
