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
    private let user = User.getUser()
    
    // MARK: - UI Elements
    private lazy var userNameTF: UITextField = {
        createTextField(
            text: user.login,
            placeholder: "User Name",
            returnKeyType: .next
        )
    }()
    
    private lazy var passwordTF: UITextField = {
        createTextField(
            text: user.password,
            placeholder: "Password",
            returnKeyType: .done,
            secureTextEntry: true
        )
    }()
    
    private lazy var loginButton: UIButton = {
        createButton(
            title: "Log in",
            font: .systemFont(ofSize: 15),
            color: .systemBlue,
            titleColor: .white,
            radius: 10,
            autoresizing: false,
            action: loginButtonAction
        )
    }()
    
    private lazy var forgotUserNameButton: UIButton = {
        createButton(
            title: "Forgot User Name?",
            font: .systemFont(ofSize: 13),
            action: questionButtonAction,
            tag: 0
        )
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        createButton(
            title: "Forgot Password?",
            font: .systemFont(ofSize: 13),
            action: questionButtonAction,
            tag: 1
        )
    }()
    
    private lazy var authStackView: UIStackView = {
        createStackView(
            subviews: [userNameTF, passwordTF, loginButton],
            axis: .vertical,
            distribution: .fill,
            spacing: 16
        )
    }()
    
    private lazy var questionsStackView: UIStackView = {
        createStackView(
            subviews: [forgotUserNameButton, forgotPasswordButton],
            axis: .horizontal,
            distribution: .equalSpacing,
            spacing: 0
        )
    }()
    
    private lazy var mainStackView: UIStackView = {
        createStackView(
            subviews: [authStackView, questionsStackView],
            axis: .vertical,
            distribution: .fill,
            spacing: 16,
            autoresizing: false
        )
    }()
    
    // MARK: -  Action
    private lazy var loginButtonAction = UIAction { [ unowned self ] _ in
        loginButtonTapped()
    }
    
    private lazy var questionButtonAction = UIAction { [ unowned self ] action in
        guard let sender = action.sender as? UIButton else { return }
        
        switch sender.tag {
        case 0:
            showAlert(title: "Oops!", message: "Your name is \(user.login) 😉")
        default:
            showAlert(title: "Oops!", message: "Your password is \(user.password) 😉")
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
        
        print("User ID: ", user.id)
    }
    
    func addSubviews() {
        view.addSubview(mainStackView)
    }
    
    func loginButtonTapped() {
        if userNameTF.text != user.login || passwordTF.text != user.password {
            showAlert(
                title: "Invalid login or password",
                message: "Please, enter correct login and password",
                textField: passwordTF
            )
        } else {
            transferData()
        }
    }
    
    func createTextField(text: String,
                         placeholder: String,
                         returnKeyType: UIReturnKeyType,
                         secureTextEntry: Bool? = nil) -> UITextField {
        
        let textField = UITextField()
        textField.text = text
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.returnKeyType = returnKeyType
        textField.isSecureTextEntry = secureTextEntry ?? false
        textField.delegate = self
        
        return textField
    }
    
    func createButton(title: String,
                      font: UIFont,
                      color: UIColor? = nil,
                      titleColor: UIColor? = nil,
                      radius: CGFloat? = nil,
                      autoresizing: Bool? = nil,
                      action: UIAction,
                      tag: Int? = nil) -> UIButton {
        
        let button = UIButton(type: .system, primaryAction: action)
        button.backgroundColor = color
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.layer.cornerRadius = radius ?? 0
        button.tag = tag ?? 3
        button.translatesAutoresizingMaskIntoConstraints = autoresizing ?? true
        
        return button
    }
    
    func createStackView(subviews: [UIView],
                         axis: NSLayoutConstraint.Axis,
                         distribution: UIStackView.Distribution,
                         spacing: CGFloat,
                         autoresizing: Bool? = nil) -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = distribution
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = autoresizing ?? true
        
        return stackView
    }
    
    func transferData() {
        let tabBarController = TabBarController()
        guard let viewControllers = tabBarController.viewControllers else { return }
        viewControllers.forEach({ viewController in
            if let navController = viewController as? UINavigationController {
                if let welcomeVC = navController.topViewController as? WelcomeViewController {
                    welcomeVC.user = user
                } else if let userInfoVC = navController.viewControllers.last as? UserInfoViewController {
                    userInfoVC.user = user
                }
            }
        })
        
        tabBarController.modalPresentationStyle = .fullScreen
        
        present(tabBarController, animated: true)
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

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTF {
            passwordTF.becomeFirstResponder()
        } else {
            loginButtonTapped()
        }
        return true
    }
}

