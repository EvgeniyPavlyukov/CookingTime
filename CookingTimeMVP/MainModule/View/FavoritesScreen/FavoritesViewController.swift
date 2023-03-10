////
////  ViewController.swift
////  MVP еще раз
////
////  Created by Eвгений Павлюков on 12.02.2023.
////

import UIKit

class FavoritesViewController: UIViewController { //Это типа вью
    
//    var presenter: FavoritesViewPresenterProtocol! //будет собирать снаружи
    var presenterMain: MainViewPresenterProtocol!

    public var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(FavoritesTableCustomCell.self, forCellReuseIdentifier: FavoritesTableCustomCell.identifier)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarNavBarSetUp()
        delegatesSetUp()
        viewSetUp()
        addConstraints()
    }
    
    func viewSetUp() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    func delegatesSetUp() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tabBarNavBarSetUp() {
        let imageName = "star.fill"
        let title = "Favorites"
        self.title = title
        self.navigationController?.tabBarItem.image = UIImage(systemName: "star")
        self.navigationController?.tabBarItem.selectedImage = UIImage(systemName: imageName)
        navigationItem.title = title
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


extension FavoritesViewController: FavoritesViewProtocol {
   
    func failure(error: String) {
        print(error)
    }
    
    func success() {
//        UIRefreshControl().endRefreshing()
        tableView.reloadData()
    }
}


extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenterMain.recipiesFavorites?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let itemCell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableCustomCell.identifier, for: indexPath) as? FavoritesTableCustomCell {

            let recepy = presenterMain.recipiesFavorites?[indexPath.row]
            let imageURL = recepy?.image
            itemCell.myLabel.text = recepy?.title
            itemCell.myImageView.downloaded(from: imageURL ?? "")
            itemCell.myImageView.clipsToBounds = true
            itemCell.myImageView.layer.cornerRadius = 50
            

            return itemCell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipy = presenterMain.recipiesFavorites?[indexPath.row]
        presenterMain.tapOnTheRecipe(recipy)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            presenterMain.recipiesFavorites?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }

}





