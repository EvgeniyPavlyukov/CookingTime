//
//  FavoritesPresenter.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 14.02.2023.
//

import Foundation

protocol FavoritesViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol FavoritesViewPresenterProtocol: AnyObject {
    init(view: FavoritesViewProtocol, netvorkService: NetworkServiceProtocol, router: RouterProtocol)
    func getRecepies()
}

class FavoritesPresenter: FavoritesViewPresenterProtocol {

    weak var view: FavoritesViewProtocol? // презентер управляет вьюхой
    let networkService: NetworkServiceProtocol! // презентер управялет моделью
    var router: RouterProtocol?
    var recipies: [Recipe]?
    
    required init(view: FavoritesViewProtocol, netvorkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = netvorkService
        self.router = router
    }
    
    //MARK: - Получаем рецепты из UserDefaults при загрузке экрана при сборке черезе Ассемблер кладем Коллекцию в переменную и уведомляем главный экран что все пришло, обновляем на главном потоке.
    
    func getRecepies() {
        
        //здесь надо взять парс из заметок
        
//        networkService.getModelFromInternet { [weak self] result in
//            guard let self = self else { return }
//
//            DispatchQueue.main.async { //чтобы пришло после того как загрузится вью
//                switch result {
//                case .success(let recipies):
//                    self.recipies = recipies?.recipes
//                    self.view?.success()
//                case .failure(let error):
//                    self.view?.failure(error: error)
//                }
//            }
//        }
    }
    
    
}
