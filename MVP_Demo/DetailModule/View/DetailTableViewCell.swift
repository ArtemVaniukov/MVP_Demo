//
//  DetailTableViewCell.swift
//  MVP_Demo
//
//  Created by Artem Vaniukov on 06.02.2022.
//

import UIKit


class DetailTableViewCell: UITableViewCell {
    
    private var hashLabel: UILabel = {
        $0.text = "#"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 15)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return $0
    }(UILabel())
    
    var postIdLabel: UILabel = {
        $0.font = .systemFont(ofSize: 30)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return $0
    }(UILabel())
    
    var headLabel: UILabel = {
        $0.font = .systemFont(ofSize: 17, weight: .heavy)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return $0
    }(UILabel())
    
    var bodyLabel: UILabel = {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.lineBreakMode = .byClipping
        return $0
    }(UILabel())
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addAutoLayoutSubviews(hashLabel, postIdLabel, headLabel, bodyLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        postIdLabel.text = ""
        headLabel.text = ""
        bodyLabel.text = ""
    }
    
}

extension DetailTableViewCell {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            hashLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            hashLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            postIdLabel.leadingAnchor.constraint(equalTo: hashLabel.trailingAnchor, constant: 5),
            postIdLabel.topAnchor.constraint(equalTo: topAnchor),
            postIdLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            headLabel.leadingAnchor.constraint(equalTo: postIdLabel.trailingAnchor, constant: 15),
            headLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            headLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            bodyLabel.leadingAnchor.constraint(equalTo: postIdLabel.trailingAnchor, constant: 15),
            bodyLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 5),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
