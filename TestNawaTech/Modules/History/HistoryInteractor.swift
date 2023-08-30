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
        NetworkManager.shared.fetchCollection(reference: .purchases, where: predicate) { [weak self] (result: Result<[PurchaseModel], Error>) in
            guard let self = self else{return}
            switch result{
            case .success(let purchases):
                fetchMotorcycles(purchases: purchases)
            case .failure(let error):
                self.presenter?.result(result: .failure(error))
            }
        }
    }
    
    func fetchMotorcycles(purchases: [PurchaseModel]){
        let group = DispatchGroup()
        for purchase in purchases{
            group.enter()
            self.fetchMotorcycle(purchase: purchase, completion: { (motorcycle) in
                purchase.motorCycle = motorcycle
                group.leave()
            })
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else{return}
            self.presenter?.result(result: .success(.successfullyFetchedHistory(purchases)))
        }
    }
    
    func fetchMotorcycle(purchase: PurchaseModel, completion: @escaping(MotorcycleModel?) -> Void){
        guard let id = purchase.motorcycleId else{
            completion(nil)
            return
        }
        let predicate = NSPredicate(format: "id == %@", id)
        NetworkManager.shared.fetchCollection(reference: .motorcycles, where: predicate) { (result: Result<[MotorcycleModel], Error>) in
            switch result{
            case .success(let motorcycles):
                print(motorcycles)
                guard let motorcycle = motorcycles.first else{
                    completion(nil)
                    return
                }
                completion(motorcycle)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getChartData(purchases: [PurchaseModel]){
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
    
    func confirmOrder(purchase: PurchaseModel) {
        purchase.status = PurchaseStatus.finished.rawValue
        NetworkManager.shared.setDocument(model: purchase, document: .purchase(purchase.transactionId ?? "")) { [weak self] (result: Result<PurchaseModel, Error>) in
            switch result{
            case .success(let purchase):
                self?.presenter?.result(result: .success(.successfullyConfirmOrder(purchase)))
            case .failure(let error):
                self?.presenter?.result(result: .failure(error))
            }
        }
    }
    
    func cancelOrder(purchase: PurchaseModel) {
        purchase.status = PurchaseStatus.cancelled.rawValue
        NetworkManager.shared.setDocument(model: purchase, document: .purchase(purchase.transactionId ?? "")) { [weak self] (result: Result<PurchaseModel, Error>) in
            switch result{
            case .success(let purchase):
                self?.refundUserBalance(purchase: purchase)
            case .failure(let error):
                self?.presenter?.result(result: .failure(error))
            }
        }
    }
    
    func refundUserBalance(purchase: PurchaseModel){
        guard let user = UserDefaultHelper.shared.getProfile(), let userId = user.id, var balance = user.balance, let amount = purchase.total else{
            presenter?.result(result: .failure(CustomError.refundProblem))
            return
        }
        balance += amount
        NetworkManager.shared.updateDocumentField(key: UserProfileModel.CodingKeys.balance.rawValue, value: balance, document: .user(userId)) { [weak self] error in
            if let error = error{
                self?.presenter?.result(result: .failure(CustomError.refundProblem))
                return
            }
            NetworkManager.shared.fetchProfile(completion: nil)
            self?.presenter?.result(result: .success(.successfullyCancelOrder(purchase)))
        }
    }
    
    func getThisMonthPurchases(purchases: [PurchaseModel], currentMonth: Int) -> [PurchaseModel]{
        return purchases.filter({ purchase in
            guard purchase.enumStatus == .finished else{return false}
            guard let date = purchase.date?.getDate(format: Date.defaultDateFormat) else{return false}
            return date.get(.month, calendar: .current) == currentMonth
        })
    }
}
