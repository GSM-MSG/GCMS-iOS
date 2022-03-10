//
//  AcceptCell.swift
//  GCMS
//
//  Created by Sunghun Kim on 2022/03/08.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import SnapKit
import Service
import Kingfisher

final class AcceptCell : BaseTableViewCell<User> {
    
    // MARK: - Properties
    
    private let userImageView = UIImageView().then {
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    private let userNameLabel = UILabel().then {
        $0.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 13)
    }
    
    private let classLabel = UILabel().then {
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 11)
        $0.textColor = GCMSAsset.Colors.gcmsGray3.color
    }

    
    private let refuseButton = UIButton().then {
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.setTitle("거절", for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 14)
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray1.color.cgColor
    }
    
    private let approveButton = UIButton().then {
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.setTitle("승인", for: .normal)
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 14)
    }
    
    // MARK: - UI
    
    override func configureCell() {
        backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    override func addView() {
        contentView.addSubViews(userImageView,userNameLabel,classLabel,refuseButton,approveButton)
    }
    override func setLayout() {
        userImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.height.width.equalTo(40)
        }
        userNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalTo(userImageView.snp.trailing).offset(9)
        }
        
        classLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom)
            $0.leading.equalTo(userImageView.snp.trailing).offset(9)
        }
        approveButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(42)
            $0.height.equalTo(27)
        }
        refuseButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(approveButton.snp.leading).offset(-12)
            $0.width.equalTo(42)
            $0.height.equalTo(27)
        }
        
    }
    
    override func bind(_ model: User) {
        userImageView.kf.setImage(with: URL(string: model.picture) ?? .none,
                                       placeholder: UIImage(),
                                       options: [])
        userNameLabel.text = model.name
        classLabel.text = "\(model.grade)학년 \(model.class)반 \(model.number)번"
    }
    
}
