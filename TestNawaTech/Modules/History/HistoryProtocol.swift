//
//  HistoryProtocol.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 29/08/23.
//

import UIKit

protocol HistoryPresenterToViewProtocol{
    var presenter: HistoryViewToPresenterProtocol? {get set}
    func result(result: Result<HistorySuccessType, Error>)
}

protocol HistoryViewToPresenterProtocol{
    var view: HistoryPresenterToViewProtocol? {get set}
    var router: HistoryPresenterToRouterProtocol? {get set}
    func viewDidLoad()
    func getChartData(purchases: [Purchase])
    func presentTableViewOptions(vc: UIViewController, purchase: Purchase)
}

protocol HistoryPresenterToInteractorProtocol{
    var presenter: HistoryInteractorToPresenterProtocol? {get set}
    func fetchHistory()
    func getChartData(purchases: [Purchase])
    func cancelOrder(purchase: Purchase)
}


protocol HistoryInteractorToPresenterProtocol{
    var interactor: HistoryPresenterToInteractorProtocol? {get set}
    func result(result: Result<HistorySuccessType, Error>)
}

protocol HistoryPresenterToRouterProtocol{
    static func makeComponent() -> HistoryViewController
}

enum HistorySuccessType{
    case successfullyFetchedHistory([Purchase])
    case successfullyFetchedChartData(([String], [CGFloat]))
    case successfullyCancelOrder(Purchase)
}
