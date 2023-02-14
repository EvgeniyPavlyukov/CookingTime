//
//  ViewController.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 12.02.2023.
//

import UIKit

class MainViewController: UIViewController { //Это типа вью
    
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
        tableView.dataSource = self
        view.addSubview(tableView)
        addConstraints()
    }

    @objc func didTapButtonAction() {
    
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

extension MainViewController: MainViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.recipies?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let itemCell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell {
            
            let recepy = presenter.recipies?[indexPath.row]
            itemCell.myLabel.text = recepy?.title
            
            let imageURL = recepy?.image
            itemCell.myImageView.downloaded(from: imageURL ?? "")
            
            return itemCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipy = presenter.recipies?[indexPath.row]
        presenter.tapOnTheRecipe(recipy)
    }
    
}

//MARK: - Вот это надо вынести в презентер

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}




