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
        let label = UILabel()
        label.text = """
            Welcome, \(user.login)!
            My name is \(user.person.fullName).
            """
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - UI Elements
    private lazy var palmLabel: UILabel = {
        let label = UILabel()
        label.text = "👋"
        label.font = .systemFont(ofSize: 58)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: buttonAction)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 21)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
        setupSubviews(welcomeLabel, palmLabel, logOutButton)
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    func setupNavigationController() {
        title = "LoginApp"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
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
            welcomeLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            welcomeLabel.topAnchor.constraint(
                
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 194
            ),
            welcomeLabel.widthAnchor.constraint(
                equalToConstant: 200
            )
        ])
    }
    
    func setConstraintsForPalmLabel() {
        NSLayoutConstraint.activate([
            palmLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            palmLabel.topAnchor.constraint(
                equalTo: welcomeLabel.bottomAnchor, constant: 40
            )
        ])
    }
    
    func setConstraintsForLogOutButton() {
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            logOutButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -122
            )
        ])
    }
}
