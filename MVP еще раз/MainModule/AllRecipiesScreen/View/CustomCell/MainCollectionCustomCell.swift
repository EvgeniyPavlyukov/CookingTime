//
//  CustomCollectionViewCell.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 14.02.2023.
//


import UIKit

class MainCollectionCustomCell: UICollectionViewCell {
    
    static let identifier = "MainCustomCell"
    
    var myImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()

    var myLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textAlignment = .left
        return myLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(myImageView)
        contentView.addSubview(myLabel)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(myImageView.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(myImageView.bottomAnchor.constraint(equalTo: myLabel.topAnchor, constant: -10))
        
        constraints.append(myLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(myLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40))
        constraints.append(myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

