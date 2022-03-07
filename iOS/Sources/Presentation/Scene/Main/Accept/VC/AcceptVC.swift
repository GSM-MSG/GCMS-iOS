//
//  AcceptVC.swift
//  GCMS
//
//  Created by Sunghun Kim on 2022/03/07.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import Service
import RxSwift
import SnapKit

final class AcceptVC : BaseVC<AcceptReactor> {
    // MARK: - Properties
    
    private let contentView = UIScrollView()
    private let megaphoneButton = UIBarButtonItem(image: .init(systemName: "megaphone.fill")?.tintColor(GCMSAsset.Colors.gcmsGray1.color), style: .plain, target: nil, action: nil)
    
    private let bannerImageView = UIImageView().then {
        $0.backgroundColor = GCMSAsset.Colors.gcmsGray3.color
        $0.contentMode = .scaleAspectFill
    }
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 25
        $0.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    private let descriptionHeaderLabel = HeaderLabel(title: "동아리 설명")
    private let userImageView = UserHorizontalView()
    
    // MARK: - UI
    
    override func addView() {
        view.addSubViews(contentView)
        contentView.addSubViews(bannerImageView, containerView)
        containerView.addSubViews(descriptionHeaderLabel)
    }
    
    override func setLayout() {
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        bannerImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(bound.width*0.5924)
            $0.width.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        descriptionHeaderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    override func configureNavigation() {
        self.navigationItem.configTitle(title: "뭐였지")
        self.navigationItem.setRightBarButton(megaphoneButton, animated: true)
        bannerImageView.kf.setImage(with: URL(string: "https://images.unsplash.com/photo-1627483262092-9f73bdf005cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3000&q=80") ?? .none)
    }
    
    
    
}
