//
//  ViewController.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 12.02.2023.
//

import UIKit

class MainViewController: UIViewController { //Это типа вью
    
//    var greetingLabel: UILabel = {
//        let greetingLabel = UILabel(frame: CGRect(x: 150, y: 150, width: 100, height: 70))
//        greetingLabel.backgroundColor = .gray
//        greetingLabel.text = "Hi"
//        return greetingLabel
//    }()
//
//    var greetingButton: UIButton = {
//        let greetingButton = UIButton(frame: CGRect(x: 150, y: 300, width: 70, height: 30))
//        greetingButton.backgroundColor = .red
//        greetingButton.addTarget(self, action: #selector(didTapButtonAction), for: .touchUpInside)
//        return greetingButton
//    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        
        return tableView
    }()
    
    var presenter: MainViewPresenterProtocol! //будет собирать снаружи

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        view.addSubview(greetingLabel)
//        view.addSubview(greetingButton)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        addConstraints()
    }

    @objc func didTapButtonAction() {
        self.presenter.showGreeting()
    }
    
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }

}

extension MainViewController: MainViewProtocol {  //а вот тут мы уже обновляем данные
    func setGreeting(greeting: String) {
//        self.greetingLabel.text = greeting
    }
}

extension MainViewController: UITableViewDelegate {
    
}


extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let itemCell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell {
             
            itemCell.myLabel.text = "\(indexPath.row)"
            
            return itemCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
