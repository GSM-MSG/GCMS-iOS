//
//  ManagementVC.swift
//  GCMS
//
//  Created by Sunghun Kim on 2022/03/02.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import SnapKit
import PinLayout
import RxSwift
import RxCocoa
import RxDataSources
import Reusable
import Service

final class ManagementVC : BaseVC<ManagementReactor> {
    // MARK: - Properties
    private let button2 = UIButton().then {
        $0.contentMode = .scaleToFill
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.setTitle("동아리 개설", for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 14)
        $0.tintColor = .white
        $0.imageEdgeInsets = .init(top: 0, left: 5, bottom: 0, right: 0)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.imageView?.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
    }
    
    private let barbutton = UIBarButtonItem()
    
    let collectionViewHeaderReuseIdentifier = "InteractiveHeader"
    
    private let managementCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        layoutConfig.headerMode = .supplementary
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        layout.scrollDirection = .horizontal
        $0.register(cellType: ClubListCell.self)
        layout.itemSize = CGSize(width: 166, height: 205)
        $0.collectionViewLayout = layout
        $0.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    // MARK: - UI
    
    override func setup() {
    }
    
    override func addView() {
        view.addSubview(managementCollectionView)
    }
    
    override func setLayoutSubviews() {
        managementCollectionView.snp.makeConstraints {
            $0.height.equalTo(bound.height * 0.9)
            $0.width.equalTo(bound.width * 0.9)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureNavigation() {
        self.navigationController?.navigationBar.setClear()
        barbutton.customView = button2
        self.navigationItem.rightBarButtonItem = barbutton
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    // MARK: - Reactor
    
    override func bindAction(reactor: ManagementReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: ManagementReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)

        
        let ds = RxCollectionViewSectionedReloadDataSource<ClubListSection>{ _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip) as ClubListCell
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.clubList)
            .bind(to: managementCollectionView.rx.items(dataSource: ds))
            .disposed(by: disposeBag)
    }
    
    
}

extension ManagementVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClubListCell", for: indexPath) as! ClubListCell
        cell.data
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 180.0)
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
            return CGSize(width: 60.0, height: 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
                
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionViewHeaderReuseIdentifier, for: indexPath)
                
                headerView.backgroundColor = UIColor.blue
                return headerView
        default:
               
               assert(false, "Unexpected element kind")
           }
        }
    }


class InteractiveHeader: UICollectionReusableView {
    
    let titleLabel = UILabel().then {
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 14)
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews(titleLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}

