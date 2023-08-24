//
//  HomeViewController.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import UIKit

class HomeViewController: UIViewController{
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(MotorcycleCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.accessibilityIdentifier = "MotorcycleCatalogCollectionView"
        return collectionView
    }()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    var presenter: HomeViewToPresenterProtocol?
    var motorcycles: [Motorcycle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Motorcycle Catalog"
        navigationController?.navigationBar.prefersLargeTitles = true
        presenter?.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        addCollectionView()
        view.backgroundColor = .systemBackground
        print("hey")
    }
    
    func addCollectionView(){
        view.addSubview(collectionView)
        collectionView.refreshControl = refreshControl
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
    
    @objc private func refresh(_ sender: Any) {
        // Fetch Weather Data
        presenter?.refreshData()
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
            collectionView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func handleFailure(_ error: Error){
        print(error.localizedDescription)
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return motorcycles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MotorcycleCollectionViewCell
        cell.setupData(motorcycle: motorcycles[indexPath.row], isEditingMode: true)
        cell.accessibilityIdentifier = "MotorcycleCatalogCollectionViewCell\(indexPath.row)"
        print("MotorcycleCatalogCollectionViewCell\(indexPath.row)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width / 2 - 60, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.goToMotorcycleDetailPage(self, motorcycle: motorcycles[indexPath.row])
    }
    
}
