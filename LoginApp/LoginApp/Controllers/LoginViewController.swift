//
//  LoginViewController.swift
//  LoginApp
//
//  Created by Matvei Khlestov on 30.03.2024.
//

import UIKit

// MARK: - LoginViewController
final class LoginViewController: UIViewController {
    
    // MARK: - Private Properties
    private let user = "Matvei"
    private let password = "password"
    
    // MARK: - UI Elements
    private lazy var userNameTF: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = "User Name"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var passwordTF: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: loginButtonAction)
        button.backgroundColor = .systemBlue
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var forgotUserNameButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: questionButtonAction)
        button.setTitle("Forgot User Name?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.tag = 0
        
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: questionButtonAction)
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.tag = 1
        
        return button
    }()
    
    private lazy var authStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            userNameTF, passwordTF, loginButton
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var questionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            forgotUserNameButton, forgotPasswordButton
        ])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            authStackView, questionsStackView
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // MARK: -  Action
    private lazy var loginButtonAction = UIAction { [ unowned self ] _ in
        if userNameTF.text != user || passwordTF.text != password {
            showAlert(
                title: "Invalid login or password",
                message: "Please, enter correct login and password",
                textField: passwordTF
            )
        } else {
            let welcomeVC = WelcomeViewController()
            welcomeVC.user = user
            welcomeVC.modalPresentationStyle = .fullScreen
            
            present(welcomeVC, animated: true)
        }
    }
    
    private lazy var questionButtonAction = UIAction { [ unowned self ] action in
        guard let sender = action.sender as? UIButton else { return }
        
        switch sender.tag {
        case 0:
            showAlert(title: "Oops!", message: "Your name is \(user) 😉")
        default:
            showAlert(title: "Oops!", message: "Your password is \(password) 😉")
        }
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        userNameTF.text = ""
        passwordTF.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

// MARK: - Private Methods
private extension LoginViewController {
    func setupView() {
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        setupSubviews(mainStackView)
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
}

// MARK: - Constraints
private extension LoginViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor, constant: -32
            ),
            mainStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40
            ),
            mainStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40
            )
        ])
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(
                equalToConstant: 40
            )
        ])
    }
}

// MARK: - Alert Controller
extension LoginViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

