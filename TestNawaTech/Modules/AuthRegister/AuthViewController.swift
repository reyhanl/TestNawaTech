//
//  RegisterViewController.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController{
    
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
        textField.delegate = self
        textField.validation = [.isAValidEmailAddress]
        textField.addTarget(target: self, selector: #selector(textDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Input your password"
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        textField.backgroundColor = .systemFill
        textField.delegate = self
        textField.validation = [.minimumNumberOfLetter(6)]
        textField.addTarget(target: self, selector: #selector(textDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var confirmationPasswordTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "re-input your password"
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        textField.backgroundColor = .systemFill
        textField.delegate = self
        textField.validation = [.minimumNumberOfLetter(6)]
        textField.addTarget(target: self, selector: #selector(textDidChange(_:)), for: .editingChanged)
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
        button.backgroundColor = .clear
        button.setTitle("Already have an account?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    var presenter: AuthViewToPresenterProtocol?
    var auth: AuthType = .signIn
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        view.backgroundColor = .systemBackground
        addContainer()
        addStackView()
        addEmailTextField()
        addPasswordTextField()
        addConfirmationPasswordTextField()
        addRegisterButton()
        addAlreadyButton()
        updateUI()
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
        }catch{
            
        }
    }
    
    func updateUI(){
        switch auth {
        case .signIn:
            setupForSignIn()
        case .signUp:
            setupForSignUp()
        }
    }
    
    private func setupForSignIn(){
        confirmationPasswordTextField.isHidden = true
        emailTextField.shouldValidate = false
        passwordTextField.shouldValidate = false
        button.isEnabled = true
        alreadyHaveAnAccountButton.setTitle("Do not have an account? Register", for: .normal)
    }
    
    private func setupForSignUp(){
        confirmationPasswordTextField.isHidden = false
        emailTextField.shouldValidate = true
        passwordTextField.shouldValidate = true
        confirmationPasswordTextField.shouldValidate = true
        alreadyHaveAnAccountButton.setTitle("Already have an account? Sign in", for: .normal)
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
    
    func addConfirmationPasswordTextField(){
        textFieldStackView.addArrangedSubview(confirmationPasswordTextField)
        confirmationPasswordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor, multiplier: 1).isActive = true
        confirmationPasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
        guard auth == .signUp else{return}
        let enabled = emailTextField.status == .valid && passwordTextField.status == .valid && confirmationPasswordTextField.status  == .valid
        button.isEnabled = enabled
    }
    
    @objc func signUp(){
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else{return}
        if auth == .signIn{
            presenter?.signIn(email: email, password: password)
        }else{
            presenter?.register(email: email, password: password)
        }
    }
    
    @objc func goToSignIn(){
        if auth == .signIn{
            presenter?.goToSignUp(from: self)
        }else{
            presenter?.goToSignIn(from: self)
        }
    }
    
    @objc func textDidChange(_ sender: UITextField){
        if sender === passwordTextField, let text = passwordTextField.text{
            let pattern = "^" + NSRegularExpression.escapedPattern(for: text) + "$"
            confirmationPasswordTextField.validation = [.minimumNumberOfLetter(6), .custom(pattern)]
        }
        updateButton()
    }
}

extension AuthViewController: AuthPresenterToViewProtocol{
    func result(result: Result<AuthSuccessType, Error>) {
        switch result{
        case .success(let type):
            handleSuccess(type: type)
        case .failure(let error):
            handleError(error)
        }
    }
    
    func handleSuccess(type: AuthSuccessType){
        switch type {
        case .successfullyRegister(let refreshToken):
            UserDefaults.standard.setValue(refreshToken, forKey: "refreshToken")
        case .successfullySignIn(let refreshToken):
            UserDefaults.standard.setValue(refreshToken, forKey: "refreshToken")
        }
        //Scene delegate / AuthListener will automatically get user to HomeVC
    }
    
    func handleError(_ error: Error){
        if let error = error as? CustomError{
            switch error{
            case .failedToSignIn(let localizedDescription):
                presentBubbleAlert(text: localizedDescription, with: 0.5, floating: 1)
                break
            case .failedToSignUp(let localizedDescription):
                presentBubbleAlert(text: localizedDescription, with: 0.5, floating: 1)
                break
            default:
                break
            }
        }
    }
}

extension AuthViewController: UITextFieldDelegate{
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        updateButton()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButton()
    }
}
