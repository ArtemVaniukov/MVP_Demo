//
//  UIView+Extension.swift
//  MVP_Demo
//
//  Created by Artem Vaniukov on 06.02.2022.
//

import UIKit



extension UIView {
    func addAutoLayoutSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
    
    func addAutoLayoutSubviews(_ views: UIView...) {
        views.forEach {
            addAutoLayoutSubview($0)
        }
    }
}
