//
//  ViewController.swift
//  MVVM_sample
//
//  Created by leewonseok on 2023/03/16.
//

import UIKit
import Combine

class ViewController: UIViewController {
    var viewModel = UserViewModel()
    
    var selectedUUID = UUID()
    
    var cancellables = Set<AnyCancellable>()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "age"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitle("생성", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let updateButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitle("수정", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let removeButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitle("삭제", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabelAndTextField()
        setupButton()
        setupTableView()
    }
    
    func setupLabelAndTextField() {
        [nameLabel, ageLabel, nameTextField, ageTextField].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            nameLabel.widthAnchor.constraint(equalToConstant: 50),
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            ageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ageLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -30),
        
            ageTextField.topAnchor.constraint(equalTo: ageLabel.topAnchor),
            ageTextField.leadingAnchor.constraint(equalTo: ageLabel.trailingAnchor, constant: 30),
            ageTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    func setupButton() {
        view.addSubview(buttonStackView)
        [addButton, updateButton, removeButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        addButton.addTarget(self, action: #selector(createUser), for: .touchUpInside)
        updateButton.addTarget(self, action: #selector(updateUser), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 30),
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -30),
        ])
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    @objc func createUser() {
        let name = nameTextField.text ?? ""
        let age = Int(ageTextField.text ?? "") ?? 0
        
        viewModel.createUser(name: name, age: age)
        
        tableView.reloadData()
    }
    
    @objc func updateUser() {
        let name = nameTextField.text ?? ""
        let age = Int(ageTextField.text ?? "") ?? 0

        viewModel.updateUser(id: selectedUUID, name: name, age: age)
    }
    
    @objc func deleteUser() {
        viewModel.deleteUser(id: selectedUUID)
        
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else {
            return UserCell()
        }
        // 바인딩
        viewModel.bindUserName(index: indexPath.row) { name in
            cell.nameLabel.text = name
        }
        viewModel.bindUserAge(index: indexPath.row) { ageString in
            cell.ageLabel.text = ageString
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUUID = viewModel.user(index: indexPath.row).id
    }
}
