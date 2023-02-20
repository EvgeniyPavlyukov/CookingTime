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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()

    var myLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textAlignment = .left
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return myLabel
    }()
    
    var myButton: UIButton = {
        let myButton = UIButton()
        myButton.translatesAutoresizingMaskIntoConstraints = false
        
        return myButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(myImageView)
        contentView.addSubview(myLabel)
        contentView.addSubview(myButton)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(myImageView.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(myImageView.bottomAnchor.constraint(equalTo: myLabel.topAnchor, constant: -10))
        
        constraints.append(myLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40))
        constraints.append(myLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40))
        constraints.append(myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        
        constraints.append(myButton.leadingAnchor.constraint(equalTo: myLabel.trailingAnchor))
        constraints.append(myButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(myButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40))
        constraints.append(myButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
