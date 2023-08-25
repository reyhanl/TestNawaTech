//
//  CustomTextView.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import UIKit

class CustomTextField: UIView{
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        return textField
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "")
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleIsSecureTextEntry))
        imageView.addGestureRecognizer(gestureRecognizer)
        return imageView
    }()
    
    var isSecureTextEntry: Bool = false{
        didSet{
            textField.isSecureTextEntry = isSecureTextEntry
            imageView.image = isSecureTextEntry ? UIImage(systemName: "eye"):UIImage(systemName: "eye.fill")
        }
    }
    var shouldShowSecureTextEntryToggle: Bool = false{
        didSet{
            imageView.isHidden = !shouldShowSecureTextEntryToggle
            if shouldShowSecureTextEntryToggle{
                isSecureTextEntry = true
            }
        }
    }
    var delegate: UITextFieldDelegate?{
        didSet{
            textField.delegate = delegate
        }
    }
    var text: String?{
        get{
            return textField.text
        }
        set{
            textField.text = newValue
        }
    }
    
    var placeholder: String{
        get{
            return textField.placeholder ?? ""
        }
        set{
            textField.placeholder = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addStackView()
        addTextField()
        addIsSecureTextEntryButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addStackView()
        addTextField()
        addIsSecureTextEntryButton()
    }
    
    private func addStackView(){
        addSubview(stackView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
    
    private func addTextField(){
        stackView.addArrangedSubview(textField)
        
//        NSLayoutConstraint.activate([
//            NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
//            NSLayoutConstraint(item: textField, attribute: .left, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10),
//            NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -10),
//            NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
//        ])
    }
    
    
    private func addIsSecureTextEntryButton(){
        stackView.addArrangedSubview(imageView)
        
//        let height = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.4, constant: 0)
//        height.priority = .defaultLow
//        let width = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.8, constant: 0)
//        width.priority = .defaultLow
//
//        NSLayoutConstraint.activate([
//            NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .lessThanOrEqual, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
//            NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
//            NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 40),
//            height,
//            NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 40),
//            width
//        ])
    }
    
    @objc private func toggleIsSecureTextEntry(){
        isSecureTextEntry.toggle()
    }
}
