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
    
}

class DetailPresenter: DetailedViewPresenterProtocol {

    weak var view: DetailedViewProtocol? // презентер управляет вьюхой
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
    
    
}
