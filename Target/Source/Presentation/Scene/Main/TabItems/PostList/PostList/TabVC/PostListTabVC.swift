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
import Then
import PinLayout
import ReactorKit
import UIKit

final class PostListTabVC: TabmanViewController, ReactorKit.View {
    // MARK: - Properties
    private var viewControllers: [UIViewController] = []
    private let logoImage = UIBarButtonItem(image: MOIZAAsset.moizaLogo.image.downSample(size: .init(width: 35, height: 35)).withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil).then {
        $0.isEnabled = false
    }
    private let majorButton = UIButton().then {
        $0.setTitle(UserDefaultsLocal.shared.major.rawValue, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.setTitleColor(MOIZAAsset.moizaGray6.color, for: .normal)
        $0.setImage(UIImage(systemName: "arrowtriangle.down.fill")?.tintColor(MOIZAAsset.moizaGray6.color).downSample(size: .init(width: 4, height: 3)), for: .normal)
        $0.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .clear
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            $0.configuration = config
            $0.configuration?.imagePlacement = .trailing
            $0.configuration?.imagePadding = 5
            $0.configuration?.baseBackgroundColor = .clear
        } else {
            $0.contentEdgeInsets = .init(top: 3, left: 10, bottom: 3, right: 10)
            $0.setBackgroundColor(.clear, for: .normal)
        }
    }
    private lazy var majorBarButton = UIBarButtonItem(customView: majorButton)
    private let searchButton = UIBarButtonItem(image: .init(systemName: "magnifyingglass")?.downSample(size: .init(width: 10, height: 10)).tintColor(MOIZAAsset.moizaGray6.color), style: .plain, target: nil, action: nil)
    private let writeFabButton = UIButton().then {
        $0.setImage(MOIZAAsset.moizaPencil.image.tintColor(MOIZAAsset.moizaConstGray1.color), for: .normal)
        $0.layer.cornerRadius = 24
        $0.backgroundColor = MOIZAAsset.moizaPrimaryYellow.color
    }
    
    var disposeBag: DisposeBag = .init()
    
    // MARK: - Init
    typealias Reactor = PostListReactor
    
    init(reactor: PostListReactor?) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setNavigation()
        if traitCollection.userInterfaceStyle == .dark { darkConfigure() }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        writeFabButton.pin.bottom(view.pin.safeArea.bottom + 16).right(16).size(48)
    }
    
    // MARK: - Method
    public func setViewControllers(_ vcs: [UIViewController]) {
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
        
        bounces = false
        
        addBar(bar, dataSource: self, at: .top)
    }
}

// MARK: - UI
private extension PostListTabVC {
    func addView(){
        view.addSubViews(writeFabButton)
    }
    func setNavigation() {
        self.navigationItem.setLeftBarButtonItems([logoImage, majorBarButton], animated: false)
        self.navigationItem.setRightBarButton(searchButton, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.configBack()
    }
    func darkConfigure() {
        majorButton.layer.borderColor = UIColor.clear.cgColor
        if #available(iOS 15.0, *) {
            majorButton.configuration?.baseBackgroundColor = MOIZAAsset.moizaDark3.color
        } else {
            majorButton.setBackgroundColor(MOIZAAsset.moizaDark3.color, for: .normal)
        }
    }
}
// MARK: - Reactor
extension PostListTabVC {
    private func bindView(reactor: PostListReactor) {
        UserDefaults.standard.rx.observe(String.self, UserDefaultsLocal.forKeys.major)
            .compactMap{ $0 }
            .map { Major(rawValue: $0) ?? .frontEnd}
            .map(Reactor.Action.majorDidChange)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    private func bindAction(reactor: PostListReactor) {
        majorButton.rx.tap
            .map { Reactor.Action.majorButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    private func bindState(reactor: PostListReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.major)
            .map(\.display)
            .withUnretained(self)
            .bind(onNext: { owner, item in
                owner.majorButton.setTitle(item, for: .normal)
                owner.majorButton.sizeToFit()
            })
            .disposed(by: disposeBag)
    }
    
    func bind(reactor: PostListReactor) {
        bindView(reactor: reactor)
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
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
        var title = ""
        switch index {
        case 0:
            title = "전체"
        case 1:
            title = "질문"
        case 2:
            title = "일반"
        default:
            title = "Anomaly"
        }
        return TMBarItem(title: title)
    }
}

