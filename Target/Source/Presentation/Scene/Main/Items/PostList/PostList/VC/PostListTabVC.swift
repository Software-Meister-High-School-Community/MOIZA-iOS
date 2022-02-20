//
//  PostListTabVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/15.
//  Copyright © 2022 com.connect. All rights reserved.
//

import Pageboy
import Tabman
import RxGesture

final class PostListTabVC: TabmanViewController {
    private var viewControllers: [UIViewController] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        self.dataSource = self
        
        let bar = TMBar.TabBar()
        bar.buttons.customize { button in
            button.tintColor = MOIZAAsset.moizaGray6.color
            button.selectedTintColor = MOIZAAsset.moizaPrimaryBlue.color
        }
        bar.indicator.overscrollBehavior = .compress
        bar.indicator.tintColor = MOIZAAsset.moizaPrimaryBlue.color
        bar.backgroundView.style = .clear
        
        addBar(bar, dataSource: self, at: .top)
    }
    
    // MARK: - Method
    public func setViewControllers(_ vcs: [UIViewController]) {
        self.viewControllers = vcs
    }
}

// MARK: - Extension
extension PostListTabVC: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .first
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "전체")
        case 1:
            return TMBarItem(title: "질문")
        case 2:
            return TMBarItem(title: "일반")
        default:
            return TMBarItem(title: "Anomaly")
        }
    }
}
