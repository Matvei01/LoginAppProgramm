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
    var user = "Matvei"
    
    // MARK: - Private Properties
    private let primaryColor = UIColor(
        red: 210/255,
        green: 109/255,
        blue: 128/255,
        alpha: 1
    )
    private let secondaryColor = UIColor(
        red: 107/255,
        green: 148/255,
        blue: 230/255,
        alpha: 1
    )
    
    // MARK: - UI Elements
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome, \(user)"
        label.textColor = .white
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
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 21)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Private Methods
private extension WelcomeViewController {
    func setupView() {
        view.addVerticalGradientLayer(
            topColor: primaryColor,
            bottomColor: secondaryColor
        )
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        setupSubviews(welcomeLabel, palmLabel, logOutButton)
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            view.addSubview(subview)
        }
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

// MARK: - Set background color
private extension UIView {
    func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
}
