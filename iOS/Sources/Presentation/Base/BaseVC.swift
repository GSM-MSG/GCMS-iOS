//
//  BaseVC.swift
//  solvedAC
//
//  Created by baegteun on 2021/10/29.
//

import UIKit
import ReactorKit

class BaseVC<T: Reactor>: UIViewController{
    let bound = UIScreen.main.bounds
    var disposeBag: DisposeBag = .init()
    
    @available(*, unavailable)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        addView()
        setLayout()
        configureVC()
    }
    
    var reactor: T
    
    init(reactor: T){
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func setup(){}
    func addView(){}
    func setLayout(){}
    func configureVC(){}
    
    func bindView(reactor: T){}
    func bindAction(reactor: T){}
    func bindState(reactor: T){}
}

extension BaseVC: View{
    func bind(reactor: T) {
        bindView(reactor: reactor)
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}
