//
//  ModelAssembler.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 12.02.2023.
//

import Foundation
import UIKit

protocol AssemblerProtocol {
    func createMain(router: RouterProtocol) -> UIViewController
    func createDetailedModule(recipy: Recipe?, router: RouterProtocol) -> UIViewController
}


class ModuleAssembler: AssemblerProtocol {
    
    func createMain(router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = MainViewController()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        
        return view
    }
    
    
    func createDetailedModule(recipy: Recipe?, router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = DetailedViewController()
        let presenter = DetailPresenter(view: view, netvorkService: networkService,router: router, recipy: recipy)
        view.presenter = presenter
        
        return view
    }
    
}
