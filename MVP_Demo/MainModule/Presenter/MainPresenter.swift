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
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getComments()
}

class MainPresenter: MainViewPresenter {
    
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol
    
    var comments: [Comment]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
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
    
}
