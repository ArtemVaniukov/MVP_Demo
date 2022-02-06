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
    init(view: DetailViewProtocol, networkService: NetworkService, comment: Comment?)
    func setComment()
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    private let networkService: NetworkService
    private var comment: Comment?
    
    required init(view: DetailViewProtocol, networkService: NetworkService, comment: Comment?) {
        self.view = view
        self.networkService = networkService
        self.comment = comment
    }
    
    func setComment() {
        view?.setComment(comment)
    }
    
}
