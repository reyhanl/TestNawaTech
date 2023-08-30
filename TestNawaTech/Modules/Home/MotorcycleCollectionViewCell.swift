//
//  MotorcycleTableViewCell.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import UIKit
import Kingfisher

class MotorcycleCollectionViewCell: UICollectionViewCell{
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var thumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var activeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var stackViewLeadingConstraint: NSLayoutConstraint?
    
    var defaultRowHeight: CGFloat = 30
    var defaultThumbImagesHeight: CGFloat = 60
    var searchCriteria: String? = nil
    var level: Int = 0
    var leadingGap: CGFloat = 20
    var isEditingMode: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addImageView()
        addTitleLabel()
        addGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    func addContainerView(){
//        addSubview(containerView)
//        let bottomConstraint = NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
//        bottomConstraint.priority = .defaultLow
//        NSLayoutConstraint.activate([
//            NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
//            NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
//            NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
//            bottomConstraint
//        ])
//    }
    func setupUI(){
        clipsToBounds = true
        backgroundColor = .secondaryBackgroundColor
        layer.cornerRadius = 10
    }
    
    private func addTitleLabel(){
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbImageView, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -20)
        ])
//
        titleLabel.text = "dwwd"
        titleLabel.numberOfLines = 0
    }
        
    func addImageView(){
        addSubview(thumbImageView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: thumbImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: thumbImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 20),            NSLayoutConstraint(item: thumbImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: thumbImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.8, constant: 0)
      ])
        thumbImageView.layer.cornerRadius = 5
    }
    
    func setupActiveStatus(){
        switch isSelected{
        case true:
            activeView.backgroundColor = .purple
            activeView.layer.borderWidth = 0
        case false:
            activeView.backgroundColor = .systemBackground
            activeView.layer.borderColor = UIColor.purple.cgColor
            activeView.layer.borderWidth = 2
        }
    }
    
    func addGestureRecognizer(){
//        containerView.isUserInteractionEnabled = true
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
//        containerView.addGestureRecognizer(gestureRecognizer)
    }
    
    func setupData(motorcycle: MotorcycleModel, isEditingMode: Bool){
        titleLabel.text = motorcycle.name
        activeView.isHidden = !isEditingMode
        self.stackViewLeadingConstraint?.constant = CGFloat(level) * leadingGap
        setupActiveStatus()
        
        setupImage(url: motorcycle.thumbImageUrl)
    }
    
    func setupData(topUp: TopUpModel, isEditingMode: Bool){
        titleLabel.text = "IDR \(topUp.amount?.giveAutoFinanceAbbreviations() ?? "")"
        titleLabel.textAlignment = .center
        let amount = topUp.amount ?? 0
        if amount < 1000000{
            thumbImageView.image = UIImage(named: "minimumMoney")
        }else if amount < 100000000{
            thumbImageView.image = UIImage(named: "someMoney")
        }else{
            thumbImageView.image = UIImage(named: "aLotOfMoney")
        }
    }
    
    func setupImage(url string: String?){
        guard let urlString = string,
              let url = URL(string: urlString)
        else{return}
        thumbImageView.kf.setImage(with: url)
    }
    
    @objc func didTap(){
        
    }
}
