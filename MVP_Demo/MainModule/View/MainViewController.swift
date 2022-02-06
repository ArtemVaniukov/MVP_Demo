//
//  MainViewController.swift
//  MVP_Demo
//
//  Created by Artem Vaniukov on 06.02.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainViewPresenter!
    
    private var label: UILabel = {
        $0.textAlignment = .center
        $0.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current).withSize(30)
        $0.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 0.8)
        $0.layer.cornerRadius = 5
        return $0
    }(UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50)))
    
    private var button: UIButton = {
        $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        $0.setTitle("Press Me", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 25
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(label)
        view.addSubview(button)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }


    @objc private func didTapButton() {
        self.presenter.showGreeting()
    }
    
}

extension MainViewController: MainViewProtocol {
    func setGreeting(greeting: String) {
        label.text = greeting
    }
}

// MARK: - Setup funcs
extension MainViewController {
    private func setupLayout() {
        label.center = view.center
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
