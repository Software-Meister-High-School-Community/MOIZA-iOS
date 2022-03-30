//
//  FollowTabVC.swift
//  MOIZA
//
//  Created by 임준화 on 2022/03/02.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Pageboy
import Tabman
import RxGesture
import Then
import PinLayout
import ReactorKit
import UIKit

final class FollowTabVC: TabmanViewController, ReactorKit.View{
    
    private var viewControllers: [UIViewController] = []
    var disposeBag: DisposeBag = .init()
    typealias Reactor = MyPageFollowReactor
    
    // MARK: - init
    init(reactor: MyPageFollowReactor?) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    
    public func setViewControllers(_ vcs: [UIViewController]){
        self.viewControllers = vcs
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.interButtonSpacing = 0
        bar.layout.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        bar.buttons.customize {
            $0.tintColor = MOIZAAsset.moizaGray6.color
            $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16) ?? .init()
            $0.selectedTintColor = MOIZAAsset.moizaPrimaryBlue.color
            $0.selectedFont = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 16)
        }
        bar.layout.contentMode = .fit
        bar.indicator.tintColor = MOIZAAsset.moizaPrimaryBlue.color
        bar.indicator.weight = .custom(value: 0.75)
        bar.backgroundView.style = .clear
        
        addBar(bar, dataSource: self, at: .top)
    }
}
extension FollowTabVC{
    public func bind(reactor: MyPageFollowReactor) {
        
    }
}

private extension FollowTabVC{
    func setNavigation(){
        self.navigationItem.setTitle(title: "asd")
        self.navigationItem.configBack()
    }
}

// MARK: - SetTab
extension FollowTabVC: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        var title = ""
        switch index {
        case 0:
            title = "800 팔로워"
        case 1:
            title = "800 팔로잉"
        default:
            title = "Anomaly"
        }
        return TMBarItem(title: title)
    }
}