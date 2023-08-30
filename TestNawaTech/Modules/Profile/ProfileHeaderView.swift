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
    lazy var balanceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.axis = .horizontal
        return stackView
    }()
    lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryForegroundColor
        return label
    }()
    lazy var balanceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "balance")
        return imageView
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
        addBalanceStackView()
        addBalanceImageView()
        addBalanceLabel()
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
            NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -10)
        ])
    }
    
    private func addBalanceStackView(){
        containerView.addSubview(balanceStackView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: balanceStackView, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: balanceStackView, attribute: .centerX, relatedBy: .equal, toItem: imageView, attribute: .centerX, multiplier: 1, constant: 0),
//            NSLayoutConstraint(item: balanceStackView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 10),
//            NSLayoutConstraint(item: balanceStackView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: balanceStackView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: balanceStackView, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 12)
        ])
    }
    
    private func addBalanceLabel(){
        balanceStackView.addArrangedSubview(balanceLabel)
    }
    
    private func addBalanceImageView(){
        balanceStackView.addArrangedSubview(balanceImageView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: balanceImageView, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 12)
        ])
    }
    
    func addGestureRecognizer(){
        containerView.isUserInteractionEnabled = true
    }
    
    func setupData(profile: Profile){
        self.profile = profile
        nameLabel.text = profile.name
        balanceLabel.text = "IDR " + (profile.balance?.giveAutoFinanceAbbreviations() ?? "0")
        setImage()
    }
    
    func setImage(){
        guard let imageUrlString = profile?.profilePictureUrl,
              let imageUrl = URL(string: imageUrlString)
        else{
            let image = UIImage(systemName: "person.fill")
            image?.withTintColor(.primaryForegroundColor)
            imageView.image = image
            imageView.tintColor = .primaryForegroundColor
            return
        }
        imageView.kf.setImage(with: imageUrl)
    }
    
    @objc func changeProfilePicture(){
        delegate?.userTapProfilePicture()
    }
}

protocol ProfileHeaderProtocol{
    func userTapProfilePicture()
}
