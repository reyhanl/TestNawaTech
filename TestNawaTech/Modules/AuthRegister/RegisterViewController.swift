//
//  RegisterViewController.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController{
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Input your email"
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .systemFill
        textField.shouldValidate = true
        textField.delegate = self
        textField.validation = [.isAValidEmailAddress]
        textField.addTarget(target: self, selector: #selector(textDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Input your password"
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        textField.backgroundColor = .systemFill
        textField.shouldValidate = true
        textField.delegate = self
        textField.validation = [.minimumNumberOfLetter(6)]
        textField.addTarget(target: self, selector: #selector(textDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var button: CustomButton = {
        let button = CustomButton(frame: .zero, backgroundColor: .primaryButton, pressedColor: .primaryButtonPressed)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return button
    }()
    
    lazy var alreadyHaveAnAccountButton: CustomButton = {
        let button = CustomButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToSignIn), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.backgroundColor = .clear
        button.setTitle("Already have an account?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    var presenter: RegisterViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        addContainer()
        addStackView()
        addEmailTextField()
        addPasswordTextField()
        addRegisterButton()
        addAlreadyButton()
        signOut()
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
        }catch{
            
        }
    }
    
    func addContainer(){
        view.addSubview(containerView)
        
        let height = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.6, constant: 0)
        height.priority = .defaultLow
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0),            NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: view, attribute: .height, multiplier: 0.6, constant: 0),
            height
        ])
    }
    
    func addStackView(){
        containerView.addSubview(textFieldStackView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: textFieldStackView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: containerView, attribute: .top, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: textFieldStackView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textFieldStackView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textFieldStackView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: textFieldStackView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: textFieldStackView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: containerView, attribute: .bottom, multiplier: 1, constant: -20)
        ])
    }
    
    func addEmailTextField(){
        textFieldStackView.addArrangedSubview(emailTextField)
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func addPasswordTextField(){
        textFieldStackView.addArrangedSubview(passwordTextField)
        passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor, multiplier: 1).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func addRegisterButton(){
        textFieldStackView.addArrangedSubview(button)
        button.widthAnchor.constraint(equalTo: emailTextField.widthAnchor, multiplier: 1).isActive = true
        button.heightAnchor.constraint(equalTo: emailTextField.heightAnchor, multiplier: 1).isActive = true
    }
    
    func addAlreadyButton(){
        textFieldStackView.addArrangedSubview(alreadyHaveAnAccountButton)
        button.widthAnchor.constraint(equalTo: emailTextField.widthAnchor, multiplier: 1).isActive = true
        alreadyHaveAnAccountButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor, multiplier: 1).isActive = true
    }
    
    func updateButton(){
        let enabled = emailTextField.status == .valid && passwordTextField.status == .valid
        button.isEnabled = enabled
    }
    
    @objc func signUp(){
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else{return}
        presenter?.register(email: email, password: password)
    }
    
    @objc func goToSignIn(){
        presenter?.goToSignIn(from: self)
    }
    
    @objc func textDidChange(){
        updateButton()
    }
}

extension RegisterViewController: RegisterPresenterToViewProtocol{
    func result(result: Result<RegisterDetailSuccessType, Error>) {
        switch result{
        case .success(let type):
            handleSuccess(type: type)
        case .failure(let error):
            handleError(error)
        }
    }
    
    func handleSuccess(type: RegisterDetailSuccessType){
        switch type {
        case .successfullyRegister(let refreshToken):
            UserDefaults.standard.setValue(refreshToken, forKey: "refreshToken")
        }
    }
    
    func handleError(_ error: Error){
        print(String(describing: error))
    }
}

extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        updateButton()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButton()
    }
}
