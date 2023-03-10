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

protocol FavoritesViewProtocol: AnyObject {
    func success() //будет отправлять сообщение нашей вьюхе
    func failure(error: String)
}

protocol MainViewPresenterProtocol: AnyObject { //будет принимать сообщение от вьюхи?
    init(view: MainViewProtocol, favoritesView: FavoritesViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) //захватываем ссылку на вью чтобы что? 2
    func getRecepies() //запрашивает рецепт из сети
    func tapOnTheRecipe(_ recipy: Recipe?)
    func tapOnAccount()
    func saveToFavorites(_ recipyID: Int?)
    var recipies: [Recipe]? {get set}
    var recipiesFavorites: [Recipe]? {get set}
}


class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol? // презентер управляет вьюхой
    weak var favoritesView: FavoritesViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol! // презентер управялет моделью
    var recipies: [Recipe]?
    var recipiesFavorites: [Recipe]?
    
    
    required init(view: MainViewProtocol, favoritesView: FavoritesViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) { //презентер нихрена не понимает откуда это приходит извне
        self.view = view
        self.favoritesView = favoritesView
        self.networkService = networkService
        self.router = router
        getRecepies() //вызовется при сборке
        recipiesFavorites = fetchFromUserDefaults()
    }
    
    //MARK: - Переход к детальному экрану рецепта
    
    func tapOnTheRecipe(_ recipy: Recipe?) {
        router?.detailedViewController(recipy: recipy)
    }
    
    //MARK: - Переход к детальному экрану Аккаунта
    
    func tapOnAccount() {
        
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
    
    //MARK: - Save to Favorites
    
    func saveToFavorites(_ recipyID: Int?) {
        guard let recipyID = recipyID, let recipies = recipies else { return }
        
        var recipy = recipies[recipyID]
        if let index = recipiesFavorites?.firstIndex(where: { $0.id == recipy.id}) { //нахожу самый первый индекс в массиве
            recipiesFavorites?.remove(at: index)
            saveToUserDefaults()
            print("рецепт удален из избранного")
            
            //здесь вызов алерт что рецепт уже есть избранном
            
        } else {
            recipiesFavorites?.append(recipy)
            saveToUserDefaults()
            print("сохранен в избранное")
            //здесь вызов алерт или всплывающее что рецепт добавлен
        }
        
        favoritesView?.success()
    }
    
    func saveToUserDefaults() {
        let encodedData = try! PropertyListEncoder().encode(self.recipiesFavorites)
        UserDefaults.standard.set(encodedData, forKey: "Favorites")
    }
    
    func fetchFromUserDefaults() -> [Recipe] {
        var fetchedModelArray = [Recipe]()
        if let fetchedData = UserDefaults.standard.data(forKey: "Favorites") {
            let fetchedDataArray = try! PropertyListDecoder().decode([Recipe].self, from: fetchedData)
            fetchedModelArray = fetchedDataArray
        }
        return fetchedModelArray
    }
}

//MARK: - Метод для подгрузки картинок, который запускается из TableView extension

extension UIImageView { //можно использовать библиотеку kingFisher 
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
    
