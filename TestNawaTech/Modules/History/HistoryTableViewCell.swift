//
//  HistoryTableViewCell.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 29/08/23.
//


import UIKit

class HistoryTableViewCell: UITableViewCell{
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var thumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    var statusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    var settingMenu: Setting?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addStackView()
        addImageView()
        addTitleLabel()
        addStatusView()
        addStatusLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addStackView(){
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 10)
        ])
    }
    
    private func addTitleLabel(){
        stackView.addArrangedSubview(titleLabel)
        titleLabel.numberOfLines = 0
    }
    
    func addImageView(){
        stackView.addArrangedSubview(thumbImageView)
        let size = 20.0
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: thumbImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0),
            NSLayoutConstraint(item: thumbImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0),
      ])
        thumbImageView.layer.cornerRadius = 5
    }
    
    func addStatusView(){
        addSubview(statusView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: statusView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: statusView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: statusView, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        ])
    }
    
    func addStatusLabel(){
        statusView.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: statusLabel, attribute: .top, relatedBy: .equal, toItem: statusView, attribute: .top, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: statusLabel, attribute: .leading, relatedBy: .equal, toItem: statusView, attribute: .leading, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: statusLabel, attribute: .trailing, relatedBy: .equal, toItem: statusView, attribute: .trailing, multiplier: 1, constant: -5),
            NSLayoutConstraint(item: statusLabel, attribute: .bottom, relatedBy: .equal, toItem: statusView, attribute: .bottom, multiplier: 1, constant: -5)
        ])
    }
    
    func setupData(purchase: PurchaseModel){
        titleLabel.text = purchase.motorCycle?.name
        statusLabel.text = purchase.enumStatus?.text
        switch purchase.enumStatus {
        case .waitingForConfirmation:
            statusView.backgroundColor = .customYellow
        case .cancelled:
            statusView.backgroundColor = .red
        case .finished:
            statusView.backgroundColor = .customGreen
        case .none:
            statusView.backgroundColor = .gray
        }
        
        guard let url = URL(string: purchase.motorCycle?.thumbImageUrl ?? "") else{return}
        thumbImageView.kf.setImage(with: url)
    }
}
