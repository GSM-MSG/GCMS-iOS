//
//  ManagementVC.swift
//  GCMS
//
//  Created by Sunghun Kim on 2022/03/02.
//  Copyright © 2022 baegteun. All rights reserved.
//

import UIKit
import Then
import PinLayout

final class ManagementVC : BaseVC<ManagementReactor> {
    
    private let button2 = UIButton().then {
        $0.setTitle("wow", for: .normal)
        $0.contentMode = .scaleToFill
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
//        $0.frame = CGRect
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -10)
    }
    
    private let barbutton = UIBarButtonItem()
    
    private let managementCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.register(cellType: ClubListCell.self)
        $0.collectionViewLayout = layout
    }
    
    override func addView() {
        view.addSubview(managementCollectionView)
    }
    
    override func configureNavigation() {
        barbutton.customView = button2
        self.navigationItem.rightBarButtonItem = barbutton
    }
    
    
    
}
