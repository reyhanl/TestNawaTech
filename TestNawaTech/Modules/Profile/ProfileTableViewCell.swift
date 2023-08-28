//
//  ProfileTableViewCell.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 28/08/23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell{
    
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
    
    var settingMenu: Setting?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addStackView()
        addImageView()
        addTitleLabel()
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
    
    func setupData(setting: Setting){
        titleLabel.text = setting.name
        thumbImageView.image = UIImage(systemName: setting.imageName)
    }
}
