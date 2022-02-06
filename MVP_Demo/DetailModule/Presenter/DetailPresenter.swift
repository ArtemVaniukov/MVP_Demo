//
//  DetailPresenter.swift
//  MVP_Demo
//
//  Created by Artem Vaniukov on 06.02.2022.
//

import Foundation



protocol DetailViewProtocol: AnyObject {
    func setComment(_ comment: Comment?)
}

protocol DetailViewPresenterProtocol {
    init(view: DetailViewProtocol, networkService: NetworkService, router: RouterProtocol, comment: Comment?)
    func setComment()
    func didTapBackButton()
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    private let networkService: NetworkService
    private var comment: Comment?
    
    required init(view: DetailViewProtocol, networkService: NetworkService, router: RouterProtocol, comment: Comment?) {
        self.view = view
        self.networkService = networkService
        self.comment = comment
        self.router = router
    }
    
    func setComment() {
        view?.setComment(comment)
    }
    
    func didTapBackButton() {
        router?.popToRoot(animated: true)
    }
    
}
