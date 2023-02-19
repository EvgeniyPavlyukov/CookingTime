//
//  DetailedPresenter.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 14.02.2023.
//

import Foundation

protocol DetailedViewProtocol: AnyObject {
    func setRecepy(_ recipy: Recipe?)
}

protocol DetailedViewPresenterProtocol: AnyObject {
    init(view: DetailedViewProtocol, netvorkService: NetworkServiceProtocol,router: RouterProtocol, recipy: Recipe?)
    func setRecepy()
//    func saveToUserDefaults(_ key: String)
}

class DetailPresenter: DetailedViewPresenterProtocol {

    weak var view: DetailedViewProtocol? // презентер управляет вьюхой
//    weak var favorite: FavoriteRecipyDelegate!
    let networkService: NetworkServiceProtocol! // презентер управялет моделью
    var router: RouterProtocol?
    var recipy: Recipe?
    
    required init(view: DetailedViewProtocol, netvorkService: NetworkServiceProtocol, router: RouterProtocol, recipy: Recipe?) {
        self.view = view
        self.networkService = netvorkService
        self.router = router
        self.recipy = recipy
    }
    
    func setRecepy() {
        self.view?.setRecepy(recipy)
    }
    
//    func saveToUserDefaults(_ key: String) {
//        let encodedData = try! PropertyListEncoder().encode(recipy)
//        UserDefaults.standard.set(encodedData, forKey: key)
//    }
//    
    
}

//extension UIImageView {
//    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//            else { return }
//            DispatchQueue.main.async() { [weak self] in
//                self?.image = image
//            }
//        }.resume()
//    }
//    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url, contentMode: mode)
//    }
//}
