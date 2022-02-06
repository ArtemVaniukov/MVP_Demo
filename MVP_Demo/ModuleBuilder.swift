//
//  ModuleBuilder.swift
//  MVP_Demo
//
//  Created by Artem Vaniukov on 06.02.2022.
//

import UIKit


protocol Builder {
    static func createMainModule() -> UIViewController
}


class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let person = Person(firstName: "Vasya", lastName: "Pupkin")
        let view = MainViewController()
        let presenter = MainPresenter(view: view, person: person)
        
        view.presenter = presenter
        
        return view
    }
}
