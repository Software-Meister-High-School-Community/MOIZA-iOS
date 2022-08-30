
import UIKit
import RxDataSources
import RxSwift
import RxViewController
import PinLayout
import FlexLayout

final class MyPageFollowingVC: BaseVC<MyFollowReactor>{
    // MARK: - Metric
    enum Metric {
        static let marginHorizontal: CGFloat = 16
    }
    
    // MARK: - Properties
    private let rootContainer = UIView()
    private let searchBar = UISearchBar().then{
        $0.searchBarStyle = .minimal
        $0.layer.cornerRadius = 5
    }
    private let followingListTableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(FollowingCell.self, forCellReuseIdentifier: FollowingCell.reusableID)
        $0.rowHeight = 77
        $0.separatorStyle = .singleLine
        $0.separatorColor = MOIZAAsset.moizaGray3.color
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    override func addView() {
        view.addSubViews(rootContainer)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.define { flex in
            flex.addItem(searchBar).marginHorizontal(Metric.marginHorizontal).marginTop(14).height(35)
            flex.addItem(followingListTableView).marginTop(20).marginHorizontal(Metric.marginHorizontal).grow(1)
        }
    }
    override func configureVC() {
        rootContainer.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    override func darkConfigure() {
        rootContainer.backgroundColor = MOIZAAsset.moizaDark2.color
    }
    
    // MARK: - Reactor
    override func bindView(reactor: MyFollowReactor) {
        
    }
    override func bindAction(reactor: MyFollowReactor) {
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: MyFollowReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        let followingDS = RxTableViewSectionedReloadDataSource<FollowingSection> { _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: FollowingCell.reusableID) as? FollowingCell else { return .init() }
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.followingItems)
            .map { [FollowingSection.init(items: $0)] }
            .bind(to: followingListTableView.rx.items(dataSource: followingDS))
            .disposed(by: disposeBag)
    }
}
