//
//  UserBioViewController.swift
//  LoginApp
//
//  Created by Matvei Khlestov on 04.04.2024.
//

import UIKit

final class UserBioViewController: UIViewController {

    // MARK: - Public Properties
    var user: User!
    
    // MARK: - UI Elements
    private lazy var userBioTextView: UITextView = {
        createTextView()
    }()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Private Methods
private extension UserBioViewController {
    func setupView() {
        view.addVerticalGradientLayer()
        addSubviews()
        setupNavigationController()
        setConstraints()
        
        print("User ID: ", user.id)
    }
    
    func addSubviews() {
        view.addSubview(userBioTextView)
    }
    
    func setupNavigationController() {
        title = "\(user.person.fullName) Bio"
    }
    
    func createTextView() -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.font = .systemFont(ofSize: 17)
        textView.text = user.person.bio
        textView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }
}

// MARK: - Constraints
private extension UserBioViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            userBioTextView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            userBioTextView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            ),
            userBioTextView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            
            userBioTextView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            )
        ])
    }
}
