//
//  ModelAssembler.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 12.02.2023.
//

import Foundation
import UIKit

protocol Assembler {
    static func createMain() -> UIViewController
}


class ModelAssembler: Assembler {
    static func createMain() -> UIViewController {
        let model = Person(firstName: "Name", lastName: "LastName")
        let view = MainViewController()
        let presenter = MainPresenter(view: view, person: model)
        view.presenter = presenter
        
        return view
    }
    
    
}
