//
//  RouterProtocol.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 14.02.2023.
//

import UIKit

protocol RouterMainProtocol { //задает всем классам свои требования
    var navigationController: UINavigationController? { get set}
//    var tabBarController: UITabBarController? { get set }
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
    var moduleAssembler: AssemblerProtocol?
    
    init(navigationController: UINavigationController, moduleAssembler: AssemblerProtocol) { //инициализатор для пуша на другие экраны
        self.navigationController = navigationController
        self.moduleAssembler = moduleAssembler
    }
    
    func initialViewController() {
        if let navigationController = navigationController { //этот пирог нужен чтобы обеспечить переходы по экранам
            guard let mainViewController = moduleAssembler?.createMain(router: self) else { return }
            guard let tabBarController = moduleAssembler?.createTabBarAndNavBar(navContrRoot: navigationController, navBarArray: mainViewController) else { return }
            navigationController.viewControllers = [tabBarController]
            navigationController.setNavigationBarHidden(true, animated: true)
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
//            navigationController.isNavigationBarHidden = true
        }
    }
    
    func popVC() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    
    
}
