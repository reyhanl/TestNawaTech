//
//  StatisticTableViewHeader.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 29/08/23.
//

import UIKit

class StatisticTableViewHeader: UITableViewHeaderFooterView{
    
    lazy var containerView: BarChartView = {
        let view = BarChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    var purchases: [Purchase] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        addContainerView()
        addGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addContainerView(){
        addSubview(containerView)
        let bottomConstraint = NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            bottomConstraint
        ])
        backgroundColor = .systemBackground
    }
    
    func addGestureRecognizer(){
        containerView.isUserInteractionEnabled = true
    }
    
    func setupData(data: ([String], [CGFloat])){
        print(data)
        containerView.dataPoints = data.0
        containerView.values = data.1
    }
}
