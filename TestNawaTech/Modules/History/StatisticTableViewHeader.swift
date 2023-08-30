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
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .primaryForegroundColor
        return label
    }()
        
    var purchases: [PurchaseModel] = []
    var currency: String = "Rp"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        addContainerView()
        addLabel()
        addGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addContainerView(){
        addSubview(containerView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
//            bottomConstraint
        ])
        backgroundColor = .systemBackground
    }
    
    func addLabel(){
        addSubview(label)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -5)
        ])
        label.textAlignment = .center
        label.text = "Currency: \(currency)"
    }
    
    func addGestureRecognizer(){
        containerView.isUserInteractionEnabled = true
    }
    
    func setupData(data: ([String], [CGFloat])){
        print(data)
        containerView.dataPoints = data.0
        containerView.values = data.1
        containerView.setNeedsDisplay()
    }
}
