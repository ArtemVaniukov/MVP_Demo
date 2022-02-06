//
//  MainViewController.swift
//  MVP_Demo
//
//  Created by Artem Vaniukov on 06.02.2022.
//

import UIKit


class MainViewController: UIViewController {
    
    var presenter: MainViewPresenter!
    
    private var tableView: UITableView = {
        $0.register(DetailTableViewCell.self, forCellReuseIdentifier: "Cell")
        $0.rowHeight = UITableView.automaticDimension
        return $0
    }(UITableView())
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addAutoLayoutSubview(tableView)
        
        navigationItem.title = "Comments"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    
}

extension MainViewController: MainViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failure(with error: Error) {        
        let alertVC = UIAlertController(title: "WHOOPS!", message: error.localizedDescription, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - TableView Data Source and Delegate
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        
        let comment = presenter.comments?[indexPath.row]
        
        cell.postIdLabel.text = "\(comment?.postId ?? -1)"
        cell.headLabel.text = comment?.name
        cell.bodyLabel.text = comment?.body
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = presenter.comments?[indexPath.row]
        presenter.didTapComment(comment)
    }
}

// MARK: - Setup funcs
extension MainViewController {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
