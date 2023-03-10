//
//  UIViewExt.swift
//  test
//
//  Created by 최형우 on 2022/01/09.
//

import UIKit

extension UIView {
    func addSubViews(_ subView: UIView...) {
        subView.forEach(addSubview(_:))
    }
    func addHeaderLabel(title: String) {
        let titleLabel = HeaderLabel(title: title)
        addSubViews(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalTo(self.snp.top).offset(-8)
        }
    }
    func addHeaderSelectionLabel(title: String) {
        let titleLabel = HeaderLabel(title: title)
        titleLabel.appendSelection()
        addSubViews(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalTo(self.snp.top).offset(-8)
        }
    }
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")

        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards

        self.layer.add(animation, forKey: nil)
    }
    func addGradientWithColor(color: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [color.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.2, 0.7]

        self.layer.insertSublayer(gradient, at: 0)
    }
}
