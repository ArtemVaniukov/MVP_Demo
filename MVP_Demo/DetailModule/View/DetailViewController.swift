//
//  DetailViewController.swift
//  MVP_Demo
//
//  Created by Artem Vaniukov on 06.02.2022.
//

import UIKit


class DetailViewController: UIViewController {
    
    var presenter: DetailViewPresenterProtocol!
    
    private var headlabel: UILabel = {
        $0.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current).withSize(30)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private var bodyLabel: UILabel = {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private var emailLabel: UILabel = {
        $0.textColor = .gray
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private var stackView: UIStackView = {
        $0.alignment = .center
        $0.distribution = .fillProportionally
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        stackView.addArrangedSubview(headlabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(emailLabel)
        
        view.addAutoLayoutSubview(stackView)
        
        presenter.setComment()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    
}

extension DetailViewController: DetailViewProtocol {
    func setComment(_ comment: Comment?) {
        navigationItem.title = "Post #\(comment?.postId ?? -1)"
        headlabel.text = comment?.name
        bodyLabel.text = comment?.body
        emailLabel.text = comment?.email
    }
}

extension DetailViewController {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
