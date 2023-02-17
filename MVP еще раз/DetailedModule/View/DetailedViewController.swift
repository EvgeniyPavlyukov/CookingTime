//
//  DetailedViewController.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 14.02.2023.
//

import UIKit



class DetailedViewController: UIViewController {
    
    deinit {
        print("DetailedVC is destroied")
    }
    
    var presenter: DetailedViewPresenterProtocol!
    
    var recipy: Recipe?
    
    var detailedImageView: UIImageView = {
        let detailedImageView = UIImageView()
        
        return detailedImageView
    }()
    
    let navBarTitle: UILabel = {
        let navBarTitle = UILabel()
        navBarTitle.minimumScaleFactor = 0.5
        navBarTitle.adjustsFontSizeToFitWidth = true
        
        return navBarTitle
    }()
    
    var detailedNameLabel: UILabel = {
        let detailedNameLabel = UILabel()
        detailedNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return detailedNameLabel
    }()
    
    var detailedIngridientsLabel: UILabel = {
        let detailedIngridientsLabel = UILabel()
        
        return detailedIngridientsLabel
    }()
    
    var detailedRecepyLabel: UILabel = {
        let detailedRecepyLabel = UILabel()
        
        return detailedRecepyLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(detailedNameLabel)
        presenter.setRecepy()
        setUpNavBar()
        addConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func setUpNavBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.titleView = navBarTitle
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(passDataToFav))
        
    }
    
    @objc func passDataToFav() {
        if let recipy = recipy {
//            presenter.saveToUserDefaults(recipy.title ?? "1")
            print("рецепт сохранен в избранное")
            }
        }

    
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(detailedNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(detailedNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(detailedNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(detailedNameLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}


extension DetailedViewController: DetailedViewProtocol {
    
    func setRecepy(_ recipy: Recipe?) {
        self.navBarTitle.text = recipy?.title
        
        self.recipy = recipy
    }

}
