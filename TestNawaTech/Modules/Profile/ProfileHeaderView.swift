//
//  ProfileHeaderView.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 28/08/23.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView{
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addTapGestureRecognizer(target: self, selector: #selector(changeProfilePicture))
        return imageView
    }()
    lazy var editImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addTapGestureRecognizer(target: self, selector: #selector(changeProfilePicture))
        return imageView
    }()
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    var profile: Profile?
    var delegate: ProfileHeaderProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        addContainerView()
        addImageView()
        addEditImageView()
        addNameLabel()
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
    
    func addImageView(){
        containerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0.3, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0.3, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 20),
        ])
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
    }
    
    func addEditImageView(){
        containerView.addSubview(editImageView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: editImageView, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 0.3, constant: 0),
            NSLayoutConstraint(item: editImageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 0.3, constant: 0),
            NSLayoutConstraint(item: editImageView, attribute: .trailing, relatedBy: .equal, toItem: imageView, attribute: .trailing, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: editImageView, attribute: .bottom, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 5),
        ])
        editImageView.clipsToBounds = true
        editImageView.image = UIImage(systemName: "pencil.circle.fill")
    }
    
    private func addNameLabel(){
        containerView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: imageView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: -10)
        ])
    }
    
    func addGestureRecognizer(){
        containerView.isUserInteractionEnabled = true
    }
    
    func setupData(profile: Profile){
        self.profile = profile
        nameLabel.text = profile.name
        setImage()
    }
    
    func setImage(){
        guard let imageUrlString = profile?.profilePictureUrl,
              let imageUrl = URL(string: imageUrlString)
        else{return}
        imageView.kf.setImage(with: imageUrl)
    }
    
    @objc func changeProfilePicture(){
        delegate?.userTapProfilePicture()
    }
}

protocol ProfileHeaderProtocol{
    func userTapProfilePicture()
}
