//
//  HistoryViewController.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 29/08/23.
//

import UIKit

class HistoryViewController: UIViewController{
    
    var presenter: HistoryViewToPresenterProtocol?
    
    lazy var chartContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StatisticTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "headerView")
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var purchases: [Purchase] = []
    var chartData: ([String], [CGFloat]) = ([], [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    func setupUI(){
        title = "My spending"
        addTableView()
    }
    
    func addTableView(){
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
    
}

extension HistoryViewController: HistoryPresenterToViewProtocol{
    
    func result(result: Result<HistorySuccessType, Error>) {
        switch result{
        case .success(let type):
            handleSuccess(type: type)
        case .failure(let error):
            handleError(error: error)
        }
    }
    
    func handleSuccess(type: HistorySuccessType){
        switch type{
        case .successfullyFetchedHistory(let purchases):
            self.purchases = purchases
            presenter?.getChartData(purchases: purchases)
        case .successfullyFetchedChartData(let chartData):
            self.chartData = chartData
            tableView.reloadData()
        }
    }
    
    func handleError(error: Error){
        presentBubbleAlert(text: String(describing: error), with: 0.2, floating: 1)
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView") as! StatisticTableViewHeader
        view.setupData(data: chartData)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileTableViewCell
        cell.titleLabel.text = purchases[indexPath.row].motorcycleId
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}
