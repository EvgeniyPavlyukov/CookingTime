//
//  MainPresenter.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 12.02.2023.
//

import Foundation
import UIKit

protocol MainViewProtocol: AnyObject { //для вьюхи 1
    func success() //будет отправлять сообщение нашей вьюхе
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject { //будет принимать сообщение от вьюхи?
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) //захватываем ссылку на вью чтобы что? 2
    func getRecepies() //запрашивает рецепт из сети
    var recipies: [Recipe]? {get set}
    func tapOnTheRecipe(_ recipy: Recipe?)
}


class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol? // презентер управляет вьюхой
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol! // презентер управялет моделью
    var recipies: [Recipe]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) { //презентер нихрена не понимает откуда это приходит извне
        self.view = view
        self.networkService = networkService
        self.router = router
        getRecepies() //вызовется при сборке
    }
    
    //MARK: - Переход к детальному экрану рецепта
    
    func tapOnTheRecipe(_ recipy: Recipe?) {
        router?.detailedViewController(recipy: recipy)
    }
    
    //MARK: - Получаем рецепты из интернета при загрузке приложения при сборке черезе Ассемблер кладем Коллекцию в переменную и уведомляем главный экран что все пришло, обновляем на главном потоке.
    
    func getRecepies() {
        networkService.getModelFromInternet { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async { //чтобы пришло после того как загрузится вью
                switch result {
                case .success(let recipies):
                    self.recipies = recipies?.recipes
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    //MARK: - Метод для подгрузки картинок, который запускается из TableView extension
    

    
    
}
