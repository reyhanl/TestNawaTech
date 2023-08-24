//
//  HomeViewController.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import UIKit

class HomeViewController: UIViewController{
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MotorcycleTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var presenter: HomeViewToPresenterProtocol?
    var motorcycles: [Motorcycle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        addTableView()
        view.backgroundColor = .systemBackground
        print("hey")
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

extension HomeViewController: HomePresenterToViewProtocol{
    
    func result(result: Result<HomeSuccessType, Error>) {
        switch result{
        case .success(let type):
            handleSuccess(type)
        case .failure(let error):
            handleFailure(error)
        }
    }
    
    func handleSuccess(_ type: HomeSuccessType){
        switch type {
        case .fetchData(let array):
            self.motorcycles = array
            tableView.reloadData()
        }
    }
    
    func handleFailure(_ error: Error){
        print(error.localizedDescription)
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return motorcycles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MotorcycleTableViewCell
        cell.setupData(motorcycle: motorcycles[indexPath.row], isEditingMode: false)
        return cell
    }
}
