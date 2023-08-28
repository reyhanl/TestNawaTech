//
//  CustomAlertViewController.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 27/08/23.
//

import UIKit

class CustomAlertViewController: UIViewController{
    
    let shadeView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.6)
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondaryBackgroundColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .primaryForegroundColor
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textColor = .primaryForegroundColor
        return label
    }()
    
    lazy var buttonStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var okeButton: UIButton = {
        let okeButton = UIButton()
        okeButton.translatesAutoresizingMaskIntoConstraints = false
        okeButton.backgroundColor = .primaryButton
        okeButton.addTarget(self, action: #selector(oke), for: .touchUpInside)
        okeButton.layer.cornerRadius = 5
        return okeButton
    }()
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.backgroundColor = .clear
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return cancelButton
    }()
    
    var text: String?{
        get{
            return titleLabel.text
        }
        set{
            titleLabel.text = newValue
        }
    }
    
    var descriptionText: String?{
        get{
            return descriptionLabel.text
        }
        set{
            descriptionLabel.text = newValue
        }
    }
    
    var actionText: String?{
        get{
            return okeButton.title(for: .normal)
        }
        set{
            okeButton.setTitle(newValue, for: .normal)
        }
    }
    
    var cancelText: String?{
        get{
            return cancelButton.title(for: .normal)
        }
        set{
            cancelButton.setTitle(newValue, for: .normal)
        }
    }
    var isCancelAble: Bool = true
    var delegate: CustomAlertDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(nibName nibNameOrNil: String? = nil,
                     bundle nibBundleOrNil: Bundle? = nil,
                     isCancelAble: Bool = true,
                     title: String? = nil,
                     description: String? = nil,
                     actionText: String? = nil,
                     cancelText: String? = nil) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.text = title
        self.descriptionText = description
        self.actionText = actionText
        self.cancelText = cancelText
        self.isCancelAble = isCancelAble
    }
    
    func setupUI(){
        addShadeView()
        addContainerView()
        addTitleLabel()
        addDescriptionLabel()
        addStackView()
        addOkeButton()
        addCancelButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cancelButton.isHidden = !isCancelAble
        shadeView.isUserInteractionEnabled = isCancelAble
    }
    
    private func addShadeView(){
        view.addSubview(shadeView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: shadeView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: shadeView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: shadeView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: shadeView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
    
    private func addContainerView(){
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.8, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        ])
    }
    
    private func addTitleLabel(){
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -20)
        ])

    }
    
    private func addDescriptionLabel(){
        containerView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: descriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -20)
        ])

    }
    
    private func addStackView(){
        containerView.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: buttonStackView, attribute: .top, relatedBy: .equal, toItem: descriptionLabel, attribute: .bottom, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: buttonStackView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: buttonStackView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: buttonStackView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: -20    )
        ])
    }
    
    private func addOkeButton(){
        buttonStackView.addArrangedSubview(okeButton)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: okeButton, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 0.8, constant: 0),
            NSLayoutConstraint(item: okeButton, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        ])
    }
    
    private func addCancelButton(){
        buttonStackView.addArrangedSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: cancelButton, attribute: .width, relatedBy: .equal, toItem: okeButton, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cancelButton, attribute: .height, relatedBy: .equal, toItem: okeButton, attribute: .height, multiplier: 1, constant: 50)
        ])
    }
    
    @objc func oke(){
        delegate?.userTapOk()
    }
    
    @objc func cancel(){
        guard isCancelAble else{return}
        delegate?.userTapOnCancel()
    }
}

protocol CustomAlertDelegate{
    func userTapOk()
    func userTapOnCancel()
}
