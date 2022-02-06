//
//  AssemblyBuilder.swift
//  MVP_Demo
//
//  Created by Artem Vaniukov on 06.02.2022.
//

import UIKit


protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(comment: Comment?, router: RouterProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = MainViewController()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        view.presenter = presenter
        
        return view
    }
    
    func createDetailModule(comment: Comment?, router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, comment: comment)
        
        view.presenter = presenter
        
        return view
    }
}
