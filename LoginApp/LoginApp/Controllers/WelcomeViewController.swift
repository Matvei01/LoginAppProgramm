//
//  WelcomeViewController.swift
//  LoginApp
//
//  Created by Matvei Khlestov on 30.03.2024.
//

import UIKit

// MARK: - WelcomeViewController
final class WelcomeViewController: UIViewController {
    
    // MARK: - Public Properties
    var user: User!
    
    // MARK: - UI Elements
    private lazy var welcomeLabel: UILabel = {
        createLabel(
            text: """
        Welcome, \(user.login)!
        My name is \(user.person.fullName).
        """,
            font: .systemFont(ofSize: 24, weight: .bold),
            textColor: .white,
            lines: 0,
            alignment: .center
        )
    }()
    
    // MARK: - UI Elements
    private lazy var palmLabel: UILabel = {
        createLabel(text: "👋", font: .systemFont(ofSize: 58))
    }()
    
    private lazy var logOutButton: UIButton = {
        createButton()
    }()
    
    // MARK: -  Action
    private lazy var buttonAction = UIAction { [ unowned self ] _ in
        dismiss(animated: true)
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Private Methods
private extension WelcomeViewController {
    func setupView() {
        view.addVerticalGradientLayer()
        addSubviews()
        setupNavigationController()
        setConstraints()
        
        print("User ID: ", user.id)
    }
    
    func addSubviews() {
        setupSubviews(
            welcomeLabel,
            palmLabel,
            logOutButton
        )
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    func setupNavigationController() {
        title = "Home"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    func createLabel(text: String,
                     font: UIFont,
                     textColor: UIColor? = nil,
                     lines: Int? = nil,
                     alignment:  NSTextAlignment? = nil) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.numberOfLines = lines ?? 1
        label.font = font
        label.textAlignment = alignment ?? .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func createButton() -> UIButton {
        let button = UIButton(type: .system, primaryAction: buttonAction)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 21)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}

// MARK: - Constraints
private extension WelcomeViewController {
    func setConstraints() {
        setConstraintsForWelcomeLabel()
        setConstraintsForPalmLabel()
        setConstraintsForLogOutButton()
    }
    
    func setConstraintsForWelcomeLabel() {
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            welcomeLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            welcomeLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 100
            )
        ])
    }
    
    func setConstraintsForPalmLabel() {
        NSLayoutConstraint.activate([
            palmLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            palmLabel.topAnchor.constraint(
                equalTo: welcomeLabel.bottomAnchor,
                constant: 40
            )
        ])
    }
    
    func setConstraintsForLogOutButton() {
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            logOutButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -122
            )
        ])
    }
}
