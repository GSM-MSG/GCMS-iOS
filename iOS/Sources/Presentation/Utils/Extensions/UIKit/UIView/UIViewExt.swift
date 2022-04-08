//
//  UIViewExt.swift
//  test
//
//  Created by 최형우 on 2022/01/09.
//

import UIKit

extension UIView{
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
}
