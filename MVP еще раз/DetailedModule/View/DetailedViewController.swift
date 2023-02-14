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
    
    var detailedImageView: UIImageView = {
        let detailedImageView = UIImageView()
        
        
        return detailedImageView
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
        addConstraints()
        presenter.setRecepy()
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
        detailedNameLabel.text = recipy?.title
    }

}
