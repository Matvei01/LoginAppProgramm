//
//  UserInfoViewController.swift
//  LoginApp
//
//  Created by Matvei Khlestov on 04.04.2024.
//

import UIKit

// MARK: - UserInfoViewController
final class UserInfoViewController: UIViewController {
    
    // MARK: - Public Properties
    var user: User!
    
    // MARK: - UI Elements
    private lazy var photoImage: UIImageView = {
        createImageView()
    }()
    
    private lazy var nameLabels: [UILabel] = {
        let labels = [
            createLabel(
                text: "Имя:",
                font: .systemFont(ofSize: 20)
            ),
            createLabel(
                text: "Фамилия:",
                font: .systemFont(ofSize: 20)
            ),
            createLabel(
                text: "Компания:",
                font: .systemFont(ofSize: 20)
            ),
            createLabel(
                text: "Отдел:",
                font: .systemFont(ofSize: 20)
            ),
            createLabel(
                text: "Должность:",
                font: .systemFont(ofSize: 20)
            )
        ]
        
        return labels
    }()
    
    private lazy var valueLabels: [UILabel] = {
        let labels = [
            createLabel(
                text: "\(user.person.name)",
                font: .italicSystemFont(ofSize: 19)
            ),
            createLabel(
                text: "\(user.person.surname)",
                font: .italicSystemFont(ofSize: 19)
            ),
            createLabel(
                text: "\(user.person.job.title)",
                font: .italicSystemFont(ofSize: 19)
            ),
            createLabel(
                text: "\(user.person.job.department.rawValue)",
                font: .italicSystemFont(ofSize: 19)
            ),
            createLabel(
                text: "\(user.person.job.jobTitle.rawValue)",
                font: .italicSystemFont(ofSize: 19)
            )
        ]
        
        return labels
    }()
    
    private lazy var multipleStackView: UIStackView = {
        createStackView(subviews: createMultipleSubviews())
    }()
    
    // MARK: -  Action
    private lazy var bioButtonPressed = UIAction { [ unowned self ] _ in
        let userBioVC = UserBioViewController()
        userBioVC.user = user
        
        navigationController?.pushViewController(userBioVC, animated: true)
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Private Methods
private extension UserInfoViewController {
    func setupView() {
        view.addVerticalGradientLayer()
        addSubviews()
        setupNavigationController()
        setConstraints()
        
        print("User ID: ", user.id)
    }
    
    func addSubviews() {
        setupSubviews(
            photoImage,
            multipleStackView
        )
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    func setupNavigationController() {
        title = user.person.fullName
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .done,
            primaryAction: bioButtonPressed
        )
    }
    
    func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = .timCook
        imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
    
    func createLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = font
        
        return label
    }
    
    func createStackView(subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    func createMultipleSubviews() -> [UIView] {
        var subviews: [UIView] = []
        for (index, label) in nameLabels.enumerated() {
            let stackView = UIStackView(arrangedSubviews: [label, valueLabels[index]])
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 16
            subviews.append(stackView)
        }
        
        return subviews
    }
}

// MARK: - Constraints
private extension UserInfoViewController {
    func setConstraints() {
        setConstraintsForPhotoImage()
        setConstraintsForMultipleStackView()
    }
    
    func setConstraintsForPhotoImage() {
        NSLayoutConstraint.activate([
            photoImage.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            photoImage.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            photoImage.heightAnchor.constraint(
                equalToConstant: 150
            ),
            photoImage.widthAnchor.constraint(
                equalToConstant: 150
            )
        ])
    }
    
    func setConstraintsForMultipleStackView() {
        NSLayoutConstraint.activate([
            multipleStackView.topAnchor.constraint(
                equalTo: photoImage.safeAreaLayoutGuide.bottomAnchor, constant: 40
            ),
            multipleStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16
            ),
            multipleStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16
            )
        ])
    }
}
