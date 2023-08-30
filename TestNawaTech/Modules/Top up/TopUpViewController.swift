//
//  TopUpViewController.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 30/08/23.
//

import UIKit

class TopUpViewController: UIViewController{
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = collectionViewInset
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(PhotoAndTextCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()

    
    var presenter: TopUpViewToPresenterProtocol?
    let collectionViewInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    var topUps: [TopUpModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    func setupUI(){
        view.backgroundColor = .systemBackground
        addCollectionView()
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

extension TopUpViewController: TopUpPresenterToViewProtocol{
    
    func result(result: Result<TopUpSuccessType, Error>) {
        switch result{
        case .success(let type):
            handleSuccess(type: type)
        case .failure(let error):
            handleError(error: error)
        }
    }
    
    func handleSuccess(type: TopUpSuccessType){
        switch type{
        case .successfullyFetchedTopUp(let topUps):
            self.topUps = topUps
            collectionView.reloadData()
            refreshControl.endRefreshing()
        case .successfullyTopUp(_):
            presentBubbleAlert(text: "You have successfully top up!", with: 0.2, floating: 1)
        }
    }
    
    func handleError(error: Error){
        presentBubbleAlert(text: error.localizedDescription, with: 0.2, floating: 1)
    }
}


extension TopUpViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topUps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoAndTextCollectionViewCell
        cell.setupData(topUp: topUps[indexPath.row], isEditingMode: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalInset = collectionViewInset.left + collectionViewInset.right
        return .init(width: view.frame.width / 2 - horizontalInset, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.topUp(topUp: topUps[indexPath.row])
    }   
    
}
