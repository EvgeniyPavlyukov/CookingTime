//
//  MainView.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 14.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MainCollectionCustomCell.self, forCellWithReuseIdentifier: MainCollectionCustomCell.identifier)

        return collectionView
    }()
    
    var presenter: MainViewPresenterProtocol! //будет собирать снаружи

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        addConstraints()
        tabBarNavBarSetUp()
    }
    
    func tabBarNavBarSetUp() {
        let imageName = "list.bullet.rectangle.portrait.fill"
        let title = "All recipies"
        navigationController?.title = title
        tabBarController?.tabBarItem.title = title
        tabBarController?.tabBarItem.image = UIImage(systemName: imageName)
        tabBarController?.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: imageName), tag: 0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
    }

    @objc func didTapButtonAction() {
    
    }
    
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }

}

extension MainViewController: MainViewProtocol {
    func success() {
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.recipies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCustomCell.identifier, for: indexPath) as? MainCollectionCustomCell {
            
            let recepy = presenter.recipies?[indexPath.row]
            itemCell.myLabel.text = recepy?.title
            let imageURL = recepy?.image
            
            itemCell.myImageView.downloaded(from: imageURL ?? "")
            
            itemCell.myImageView.clipsToBounds = true
            itemCell.myImageView.layer.cornerRadius = 30
            
            
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ConstantsCollectionView.itemWidth, height: ConstantsCollectionView.itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipy = presenter.recipies?[indexPath.row]
        presenter.tapOnTheRecipe(recipy)
    }
                

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return presenter.recipies?.count ?? 1
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let itemCell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell {
//            
//            let recepy = presenter.recipies?[indexPath.row]
//            itemCell.myLabel.text = recepy?.title
//            
//            let imageURL = recepy?.image
////            itemCell.myImageView.layer.cornerRadius = 20
////            itemCell.myImageView.contentMode = .scaleAspectFill
////            itemCell.contentView.contentMode = .scaleAspectFill
//            
//            itemCell.myImageView.downloaded(from: imageURL ?? "")
//            itemCell.myImageView.clipsToBounds = true
//            itemCell.myImageView.layer.cornerRadius = 50
//            
//            
//            return itemCell
//        }
//        return UITableViewCell()
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//    }
    
}





