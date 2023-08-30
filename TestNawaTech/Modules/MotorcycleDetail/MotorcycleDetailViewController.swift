//
//  MotorcycleDetailViewController.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import UIKit

class MotorcycleDetailViewController: UIViewController{
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .secondaryBackgroundColor
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    lazy var buttonContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .secondaryBackgroundColor
        return container
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var priceLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var purchaseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primaryButton
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Purchase", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(purchase), for: .touchUpInside)
        return button
    }()
    
    var motorcycle: MotorcycleModel?
    var presenter: MotorcycleDetailViewToPresenterProtocol?
    var heightOfTextView: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        addScrollView()
        addContainerView()
        addImageView()
        addTitleLabel()
        addDescriptionTextView()
        addButtonContainer()
        addButtonStackView()
        addPriceLabel()
        addPurchaseButton()
        guard let motorcycle = motorcycle else{return}
        setupData(motorcycle: motorcycle)
    }
    
    deinit {
        self.motorcycle = nil
    }
    
    func addScrollView(){
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        ])
    }
    
    func addContainerView(){
        scrollView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0)
        ])
    }
    
    func addImageView(){
        containerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: view.frame.height / 3)
        ])
    }
    
    func addTitleLabel(){
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -20)
        ])
        titleLabel.numberOfLines = 0
    }
    
    func addDescriptionTextView(){
        containerView.addSubview(descriptionTextView)
        
        let heightOfTextView = NSLayoutConstraint(item: descriptionTextView, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: descriptionTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: descriptionTextView, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: descriptionTextView, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: descriptionTextView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0),
            heightOfTextView
        ])
        
        self.heightOfTextView = heightOfTextView
        
        descriptionTextView.textColor = .white
    }
    
    func addButtonContainer(){
        view.addSubview(buttonContainer)
        
        let bottomPadding = view.safeAreaInsets.bottom
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: buttonContainer, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: buttonContainer, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),            NSLayoutConstraint(item: buttonContainer, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: buttonContainer, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: buttonContainer, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 80 + bottomPadding)
        ])
    }
    
    func addButtonStackView(){
        buttonContainer.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: buttonStackView, attribute: .top, relatedBy: .equal, toItem: buttonContainer, attribute: .top, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: buttonStackView, attribute: .leading, relatedBy: .equal, toItem: buttonContainer, attribute: .leading, multiplier: 1, constant: 20),            NSLayoutConstraint(item: buttonStackView, attribute: .trailing, relatedBy: .equal, toItem: buttonContainer, attribute: .trailing, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: buttonStackView, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        ])
    }
    
    func addPriceLabel(){
        buttonStackView.addArrangedSubview(priceLabel)
    }
    
    func addPurchaseButton(){
        buttonStackView.addArrangedSubview(purchaseButton)
    }
    
    func setupData(motorcycle: MotorcycleModel){
        self.motorcycle = motorcycle
        titleLabel.text = motorcycle.name
        descriptionTextView.attributedText = motorcycle.description?.htmlToAttributedString
        view.layoutIfNeeded()
        let size = CGSize(width: view.frame.width, height: 2000)
        let boundingBox = descriptionTextView.attributedText.boundingRect(
            with: size,
            options: [.usesLineFragmentOrigin, .usesFontLeading, .usesDeviceMetrics],
            context: nil
        )
        heightOfTextView?.constant = boundingBox.height
        view.layoutIfNeeded()
        priceLabel.text = "IDR \(motorcycle.price?.giveAutoFinanceAbbreviations() ?? "")"
        title = motorcycle.name
        setupImage()
    }
    
    func setupImage(){
        guard let urlString = motorcycle?.thumbImageUrl,
              let url = URL(string: urlString)
        else{return}
        imageView.kf.setImage(with: url)
    }
    
    @objc func purchase(){
        guard let motorcycle = motorcycle else{return}
        presenter?.purchase(motorcycle: motorcycle)
    }
}

extension MotorcycleDetailViewController: MotorcycleDetailPresenterToViewProtocol{
    
    func signOut(){
        //TODO: Present model to let user know that they are no longer sign in
    }
    
    func result(result: Result<MotorcycleDetailSuccessType, Error>) {
        switch result{
        case .success(let success):
            handleSuccess(type: success)
        case .failure(let error):
            handleError(error: error)
        }
    }
    
    func handleSuccess(type: MotorcycleDetailSuccessType){
        presentBubbleAlert(text: "Order has been sent to the seller", with: 0.2, floating: 1)
    }
    
    func handleError(error: Error){
        presentBubbleAlert(text: String(describing: error), with: 0.2, floating: 1)
    }
}
