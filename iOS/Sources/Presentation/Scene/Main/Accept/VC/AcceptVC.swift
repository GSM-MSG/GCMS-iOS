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
import RxDataSources
import SnapKit

class AcceptVC : BaseVC<AcceptReactor> {
    // MARK: - Properties
    private let megaphoneButton = UIBarButtonItem(image: .init(systemName: "megaphone.fill")?.tintColor(GCMSAsset.Colors.gcmsGray1.color), style: .plain, target: nil, action: nil)
         
    private let bannerImageView = UIImageView().then {
        $0.backgroundColor = GCMSAsset.Colors.gcmsGray3.color
        $0.contentMode = .scaleAspectFill
    }
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 25
        $0.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    private let descriptionHeaderLabel = HeaderLabel(title: "가입 대기중")

    private let acceptTableView = UITableView().then {
        $0.register(cellType: AcceptCell.self)
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorStyle = .none
        $0.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    // MARK: - UI
    
    override func addView() {
        view.addSubViews(bannerImageView, containerView)
        containerView.addSubViews(descriptionHeaderLabel,acceptTableView)
    }
    
    override func setLayout() {
        bannerImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(bound.width*0.5924)
            $0.width.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        descriptionHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(32)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        acceptTableView.snp.makeConstraints {
            $0.top.equalTo(descriptionHeaderLabel.snp.bottom).offset(22)
            $0.leading.trailing.equalTo(descriptionHeaderLabel)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    override func configureNavigation() {
        self.navigationItem.configTitle(title: "맛소금")
        self.navigationItem.setRightBarButton(megaphoneButton, animated: true)
        bannerImageView.kf.setImage(with: URL(string: "https://images.unsplash.com/photo-1627483262092-9f73bdf005cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3000&q=80") ?? .none)
    }
    
    // MARK: - Reactor
    
    override func bindAction(reactor: AcceptReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: AcceptReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        let studentDS = RxTableViewSectionedReloadDataSource<ApplicantSection> { _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: AcceptCell.self)
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.acceptUser)
            .compactMap { $0 }
            .map { [ApplicantSection(header: "", items: $0)] }
            .bind(to: acceptTableView.rx.items(dataSource: studentDS))
            .disposed(by: disposeBag)
        
    }
        
    override func bindView(reactor: AcceptReactor) {
        megaphoneButton.rx.tap
            .map { Reactor.Action.noticeButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
}
