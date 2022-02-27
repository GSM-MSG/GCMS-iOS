//
//  UIViewExt.swift
//  test
//
//  Created by 최형우 on 2022/01/09.
//

import UIKit

extension UIStackView{
    func addArrangeSubviews(_ views: UIView...) {
        views.forEach(addArrangedSubview(_:))
    }
}
