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
    lazy var panGR: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(leftSwipeDismiss(gestureRecognizer:)))
    
    public var enableScreenPanGesture: Bool = true {
        didSet {
            if(enableScreenPanGesture) {
                self.view.addGestureRecognizer(self.panGR)
                return
            }
            if self.view.gestureRecognizers?.contains(panGR) ?? false {
                self.view.removeGestureRecognizer(panGR)
            }
        }
    }
    @available(*, unavailable)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        enableScreenPanGesture = navigationController?.viewControllers.count ?? 0 > 1 && navigationController?.viewControllers.last == self
        setup()
        addView()
        setLayout()
        configureVC()
        configureNavigation()
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
