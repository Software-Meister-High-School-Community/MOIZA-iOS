//
//  baseVC.swift
//  solvedAC
//
//  Created by baegteun on 2021/10/29.
//

import UIKit
import ReactorKit
import Then
import SnapKit
import Hero

class baseVC<T: Reactor>: UIViewController{
    let bound = UIScreen.main.bounds
    var disposeBag: DisposeBag = .init()
    
    @available(*, unavailable)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.hero.isEnabled = true
        setUp()
        addView()
        setLayout()
        configureVC()
        configureNavigation()
    }
    
    @Inject var reactor: T
    
    init() { super.init(nibName: nil, bundle: nil) }
    
    init(reactor: T){
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func setUp(){}
    func addView(){}
    func setLayout(){}
    func configureVC(){}
    func configureNavigation(){}
    
    func bindView(reactor: T){}
    func bindAction(reactor: T){}
    func bindState(reactor: T){}
}

extension baseVC: View{
    func bind(reactor: T) {
        bindView(reactor: reactor)
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}
