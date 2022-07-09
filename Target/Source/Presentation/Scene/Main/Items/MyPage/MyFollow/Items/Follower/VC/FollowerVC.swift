
import UIKit
import RxDataSources
import RxSwift
import RxViewController
import PinLayout
import FlexLayout

final class MyPageFollowerVC: baseVC<MyPageFollowReactor>{
    
    private let headerContainer = UIView()
    
    private let searchBar = UISearchBar().then{
        $0.searchBarStyle = .minimal
        $0.layer.cornerRadius = 5
    }
    
    private let followerContainer = UIView()
    
    private let followerListTableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(FollowerCell.self, forCellReuseIdentifier: FollowerCell.reusableID)
        $0.rowHeight = 77
        $0.separatorStyle = .singleLine
        $0.separatorColor = MOIZAAsset.moizaGray3.color
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.showsVerticalScrollIndicator = false
    }
    
    override func setUp(){
        followerListTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    override func addView() {
        view.addSubViews(followerContainer)
        headerContainer.addSubViews(searchBar)
    }
    override func setLayoutSubViews() {
        followerContainer.pin.all(view.pin.safeArea)
        followerContainer.flex.layout()
        
        headerContainer.pin.width(bound.width-34).height(55)
        searchBar.pin.pinEdges().horizontally(0).marginTop(14).height(35)
    }
    override func setLayout() {
        followerContainer.flex.define { flex in
            flex.addItem(followerListTableView).grow(1).bottom(0).marginHorizontal(16)
        }
    }
    override func bindView(reactor: MyPageFollowReactor) {
    }
    override func bindAction(reactor: MyPageFollowReactor) {
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: MyPageFollowReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        let followerDS = RxTableViewSectionedReloadDataSource<FollowerSection> { _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: FollowerCell.reusableID) as? FollowerCell else { return .init() }
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.FollowerItems)
            .map { [FollowerSection.init( items: $0)] }
            .bind(to: followerListTableView.rx.items(dataSource: followerDS))
            .disposed(by: disposeBag)
    }
}
extension MyPageFollowerVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerContainer
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerContainer.frame.height
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerHeight: CGFloat = headerContainer.frame.height
        if scrollView.contentOffset.y <= headerHeight, scrollView.contentOffset.y >= 0 {
            scrollView.contentInset = .init(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
        } else if scrollView.contentOffset.y >= headerHeight {
            scrollView.contentInset = .init(top: -headerHeight, left: 0, bottom: 0, right: 0)
        }
    }
}
