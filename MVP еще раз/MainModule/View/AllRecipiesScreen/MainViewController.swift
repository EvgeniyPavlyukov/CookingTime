//
//  MainView.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 14.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
//MARK: - Variables
    
    var presenter: MainViewPresenterProtocol! //будет собираться снаружи
    let searchBar = UISearchBar()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MainCollectionCustomCell.self, forCellWithReuseIdentifier: MainCollectionCustomCell.identifier)

        return collectionView
    }()
    
//MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegatesSetUp()
        viewSetUp()
        tabBarNavBarSetUp()
        addConstraints()
    }
    
    deinit {
        print("Main vc is destroied")
    }
    
//MARK: - View SetUp
    
    func viewSetUp() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
//MARK: - Delegates
    
    func delegatesSetUp() {
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
//MARK: - Navigation Bar Settings
    
    func tabBarNavBarSetUp() {
        navigationController?.navigationController?.setNavigationBarHidden(true, animated: true)
        let imageName = "list.bullet.rectangle.portrait.fill"
        let title = "All recipies"
        self.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = title //это тайтл навигешена
        navigationController?.tabBarItem.selectedImage = UIImage(systemName: imageName) //таб бар настраивается через навигейшн контроллер
        showSearchBarButton(true)
    }
    
//MARK: - SearchBar SetUp

    @objc func didTapSearch() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    func showSearchBarButton(_ bool: Bool) {
        if bool {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    func search(shouldShow: Bool) {
        self.showSearchBarButton(!shouldShow)
        self.searchBar.showsCancelButton = shouldShow
        self.navigationItem.titleView = shouldShow ? searchBar : nil //это упрощает код в из 5 строк
    }
    
//MARK: - Constraints
    
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}

//MARK: - Presenter Protocol

extension MainViewController: MainViewProtocol {
    func success() {
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }

    
}


//MARK: - CollectionView SetUps

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // Cell quantity
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.recipies?.count ?? 0
    }
    
    // Cells setup
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCustomCell.identifier, for: indexPath) as? MainCollectionCustomCell {
            let recepy = presenter.recipies?[indexPath.row]
            let imageURL = recepy?.image
            
            itemCell.myLabel.text = recepy?.title
            itemCell.myImageView.downloaded(from: imageURL ?? "")
            itemCell.myImageView.clipsToBounds = true
            itemCell.myImageView.layer.cornerRadius = 30
            itemCell.myButton.tag = indexPath.row
            itemCell.myButton.addTarget(self, action: #selector(self.passFavoriteRecipy(sender: )), for: .touchUpInside)
            
            return itemCell
        }
        
       
        return UICollectionViewCell()
    }
            
    @objc func passFavoriteRecipy(sender: UIButton!) {
        presenter.saveToFavorites(sender.tag)
    }
    
    //Cell size and layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ConstantsCollectionView.itemWidth, height: ConstantsCollectionView.itemHeight)
    }
    
    //Cell did tap Action
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipy = presenter.recipies?[indexPath.row]
        presenter.tapOnTheRecipe(recipy)
        print("tap")
    }
}

//MARK: - SearchBar SetUp

extension MainViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
}




