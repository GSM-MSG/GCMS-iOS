//
//  BaseVC.swift
//  solvedAC
//
//  Created by baegteun on 2021/10/29.
//

import UIKit
import ReactorKit
import Lottie

class BaseVC<T: Reactor>: UIViewController{
    let bound = UIScreen.main.bounds
    var disposeBag: DisposeBag = .init()
    private lazy var indicator = AnimationView(name: "GCMS-Indicator").then {
        $0.center = view.center
        $0.contentMode = .scaleAspectFit
        $0.loopMode = .loop
        $0.stop()
        $0.isHidden = true
    }
    
    @available(*, unavailable)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        addView()
        setLayout()
        configureVC()
        configureNavigation()
        configureIndicator()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setLayoutSubviews()
    }
    
    init(reactor: T?){
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
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
    func setLayoutSubviews(){}
    func configureVC(){}
    func configureNavigation(){}
    private func configureIndicator() {
        view.addSubViews(indicator)
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(150)
        }
    }
    
    func startIndicator() {
        indicator.isHidden = false
        indicator.play()
    }
    func stopIndicator() {
        indicator.isHidden = true
        indicator.stop()
    }
    
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
