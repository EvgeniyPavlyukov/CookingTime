//
//  RouterProtocol.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 14.02.2023.
//

import UIKit

protocol RouterMainProtocol { //задает всем классам свои требования
    var navigationController: UINavigationController? { get set}
    var tabBarController: UITabBarController? { get set }
    var moduleAssembler: AssemblerProtocol? {get set}
}


protocol RouterProtocol: RouterMainProtocol { //роутер с конкретными контроллерами
    func initialViewController()
    func detailedViewController(recipy: Recipe?)
    func popToRoot()
    func popVC()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var tabBarController: UITabBarController?
    var moduleAssembler: AssemblerProtocol?
    
    init(navigationController: UINavigationController, moduleAssembler: AssemblerProtocol) { //инициализатор для пуша на другие экраны
        self.navigationController = navigationController
        self.moduleAssembler = moduleAssembler
    }
    
    init(tabBarController: UITabBarController, moduleAssembler: AssemblerProtocol) { //инициализатор для начального экрана
        self.tabBarController = tabBarController
        self.moduleAssembler = moduleAssembler
    }
    
    
    func initialViewController() {
        if let tabBarController = tabBarController {
            guard let mainViewController = moduleAssembler?.createMain(router: self) else { return }
            guard let favoritesViewController = moduleAssembler?.createFavorits(router: self) else { return }
            let navControllerMain = UINavigationController(rootViewController: mainViewController)
            let navControllerFav = UINavigationController(rootViewController: favoritesViewController)
            tabBarController.viewControllers = [navControllerMain, navControllerFav]
        }
        
    }
    
    func detailedViewController(recipy: Recipe?) {
        if let navigationController = navigationController {
            guard let detailedViewController = moduleAssembler?.createDetailedModule(recipy: recipy, router: self) else { return }
            navigationController.pushViewController(detailedViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    func popVC() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    
    
}
