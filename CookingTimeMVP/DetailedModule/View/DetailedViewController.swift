//
//  DetailedViewController.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 14.02.2023.
//

import UIKit



class DetailedViewController: UIViewController {
    
//MARK: - Variables
    
    var presenter: DetailedViewPresenterProtocol!
    
    let navBarTitle: UILabel = {
        let navBarTitle = UILabel()
        navBarTitle.minimumScaleFactor = 0.5
        navBarTitle.adjustsFontSizeToFitWidth = true
        
        return navBarTitle
    }()
    
    var detailedImageView: UIImageView = {
        let detailedImageView = UIImageView()
        detailedImageView.translatesAutoresizingMaskIntoConstraints = false
        detailedImageView.contentMode = .scaleAspectFill
        detailedImageView.clipsToBounds = true
        detailedImageView.layer.cornerRadius = 3
        
        return detailedImageView
    }()
    
    var detailedNameLabel: UILabel = {
        let detailedNameLabel = UILabel()
        detailedNameLabel.translatesAutoresizingMaskIntoConstraints = false
        detailedNameLabel.numberOfLines = 0
        
        
        return detailedNameLabel
    }()
    
    var detailedIngridientsLabel: UILabel = {
        let detailedIngridientsLabel = UILabel()
        detailedIngridientsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailedIngridientsLabel.numberOfLines = 0
        detailedIngridientsLabel.adjustsFontSizeToFitWidth = true
        
        
        return detailedIngridientsLabel
    }()
    
    var detailedRecepyLabel: UILabel = {
        let detailedRecepyLabel = UILabel()
        detailedRecepyLabel.translatesAutoresizingMaskIntoConstraints = false
        detailedRecepyLabel.numberOfLines = 0
        detailedRecepyLabel.adjustsFontSizeToFitWidth = true
        
        return detailedRecepyLabel
    }()

//MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetUp()
        presenter.setRecepy()
        setUpNavBar()
        addConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    deinit {
        print("DetailedVC is destroied")
    }
    
//MARK: - View SetUp
    
    func viewSetUp() {
        view.backgroundColor = .white
        view.addSubview(detailedImageView)
        view.addSubview(detailedIngridientsLabel)
        view.addSubview(detailedRecepyLabel)
    }
    
//MARK: - Navigation Bar Settings
    
    func setUpNavBar() {
        navigationItem.titleView = navBarTitle
    }
    
//MARK: - Constraints
    
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(detailedImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(detailedImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(detailedImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10))
        constraints.append(detailedImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(view.bounds.height / 2)))
        
        constraints.append(detailedIngridientsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(detailedIngridientsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10))
        constraints.append(detailedIngridientsLabel.topAnchor.constraint(equalTo: detailedImageView.bottomAnchor, constant: 10))
        constraints.append(detailedIngridientsLabel.bottomAnchor.constraint(equalTo: detailedImageView.bottomAnchor, constant: 60))
        
        constraints.append(detailedRecepyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(detailedRecepyLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10))
        constraints.append(detailedRecepyLabel.topAnchor.constraint(equalTo: detailedIngridientsLabel.bottomAnchor, constant: 10))
        constraints.append(detailedRecepyLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

//MARK: - Presenter Protocol

extension DetailedViewController: DetailedViewProtocol {
    
    func setRecepy(_ recipy: Recipe?) {
        
        // название в NavBar
        self.navBarTitle.text = recipy?.title
        
        //картинка
        let urlString = recipy?.image ?? ""
        self.detailedImageView.downloaded(from: urlString)
        
        //Время приготовления в лэйб
//        self.detailedNameLabel.text = "Title: \((recipy?.title)!). CookingMinutes: \((recipy?.preparationMinutes)!) minutes"
        
        //Ингридиенты
        let ingredients = recipy?.extendedIngredients
        var stringForLabel = "Ingridients: "
        
        for i in 0..<(ingredients?.count ?? 0) {
            stringForLabel += "\((ingredients?[i].name)!) \((ingredients?[i].amount)!) \((ingredients?[i].unit)!), "
        }
        
        stringForLabel.removeLast()
        stringForLabel.removeLast()
        stringForLabel.append(".")
        self.detailedIngridientsLabel.text = stringForLabel
        
        
        //Непосредственно Рецепт
        self.detailedRecepyLabel.text = "Instruction: \((recipy?.instructions)!)"
    }

}
