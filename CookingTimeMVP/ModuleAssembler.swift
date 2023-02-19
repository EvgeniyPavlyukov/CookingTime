//
//  ModelAssembler.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 12.02.2023.
//

import Foundation
import UIKit

protocol AssemblerProtocol {
    func createMain(router: RouterProtocol) -> [UIViewController]
    func createDetailedModule(recipy: Recipe?, router: RouterProtocol) -> UIViewController
    func createTabBarAndNavBar(navContrRoot: UIViewController, navBarArray: [UIViewController]) -> UITabBarController
}


class ModuleAssembler: AssemblerProtocol {
    
    func createMain(router: RouterProtocol) -> [UIViewController] {
        let networkService = NetworkService()
        let view = MainViewController()
        let favoriteView = FavoritesViewController()
        let presenter = MainPresenter(view: view, favoritesView: favoriteView, networkService: networkService, router: router) //вот так можно делать?
        view.presenter = presenter
        favoriteView.presenterMain = presenter //так мы получаем связь с экраном Избранное из главное презентера и имеем возможность сохранять в избранное рецепты
        
        return [view, favoriteView]
    }
    
    func createDetailedModule(recipy: Recipe?, router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = DetailedViewController()
        let presenter = DetailPresenter(view: view, netvorkService: networkService, router: router, recipy: recipy)
        view.presenter = presenter
        
        return view
    }
    
    
    func createTabBarAndNavBar(navContrRoot: UIViewController, navBarArray: [UIViewController]) -> UITabBarController {
        
        let tabBarVC = UITabBarController()
        let allRecipies = createNavVC(vc: navBarArray[0], imageName: "list.bullet.rectangle.portrait", itemName: "All recipies")
        let favoriteRecipies = createNavVC(vc: navBarArray[1], imageName: "star", itemName: "Favorite")

        tabBarVC.viewControllers = [allRecipies, favoriteRecipies]

        func createNavVC(vc: UIViewController, imageName: String, itemName: String) -> UINavigationController {
            let item = UITabBarItem(title: itemName, image: UIImage(systemName: imageName), tag: 0)
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]

            let navController = UINavigationController(rootViewController: vc)
            navController.tabBarItem = item

            return navController
        }

        return tabBarVC
    }
    
}
