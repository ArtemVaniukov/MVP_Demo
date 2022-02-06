//
//  MainPresenter.swift
//  MVP_Demo
//
//  Created by Artem Vaniukov on 06.02.2022.
//

import Foundation


protocol MainViewProtocol: AnyObject {
    func success()
    func failure(with error: Error)
}

protocol MainViewPresenter: AnyObject {
    var comments: [Comment]? { get set }
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getComments()
    func didTapComment(_ comment: Comment?)
}

class MainPresenter: MainViewPresenter {
    
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol
    var router: RouterProtocol?
    
    var comments: [Comment]?
    
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getComments()
    }
    
    
    func getComments() {
        networkService.fetchComments { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let comments):
                    self?.comments = comments
                    self?.view?.success()
                case .failure(let error):
                    self?.view?.failure(with: error)
                }
            }
        }
    }
    
    func didTapComment(_ comment: Comment?) {
        router?.showDetail(from: comment)
    }
    
}
