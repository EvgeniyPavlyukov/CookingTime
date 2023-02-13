//
//  CustomCell.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 12.02.2023.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var myLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.backgroundColor = .lightGray
        myLabel.textAlignment = .left
        return myLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: CustomCell.identifier)
        
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
        constraints.append(myImageView.trailingAnchor.constraint(equalTo: myLabel.leadingAnchor))
        constraints.append(myImageView.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        
        constraints.append(myLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100))
        constraints.append(myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(myLabel.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
