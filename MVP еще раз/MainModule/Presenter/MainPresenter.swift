//
//  MainPresenter.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 12.02.2023.
//

import Foundation

protocol MainViewProtocol: AnyObject { //для вьюхи 1
    func success() //будет отправлять сообщение нашей вьюхе
}

protocol MainViewPresenterProtocol: AnyObject { //будет принимать сообщение от вьюхи?
    init(view: MainViewProtocol, person: Person) //захватываем ссылку на вью чтобы что? 2
    func showGreeting()
}


class MainPresenter: MainViewPresenterProtocol {
    
    let view: MainViewProtocol // презентер управляет вьюхой
    let person: Person // презентер управялет моделью
    
    required init(view: MainViewProtocol, person: Person) { //презентер нихрена не понимает откуда это приходит извне
        self.view = view
        self.person = person
    }
    
    func showGreeting() {
        let greeting = self.person.firstName + " " + self.person.lastName //это бизнес логика
        self.view.setGreeting(greeting: greeting) //он передает то что в бизнесе собрал во вью которое подписано на этот протоко MainViewProtocol
    }
    
    
}
