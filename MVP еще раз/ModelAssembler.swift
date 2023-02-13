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
        let networkService = NetworkService()
        let view = MainViewController()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
    
    
}
