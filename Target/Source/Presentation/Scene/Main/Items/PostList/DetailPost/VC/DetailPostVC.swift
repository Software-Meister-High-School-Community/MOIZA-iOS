import UIKit
import PinLayout
import FlexLayout
import RxSwift
import RxDataSources

final class DetailPostVC: baseVC<DetailPostReactor> {
    // MARK: - Metric
    enum Metric {
        static let marginHorizontal: CGFloat = 16
    }
    // MARK: - Properties
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    private let rootContainer = UIView()
    private let headerContainer = UIView().then {
        $0.backgroundColor = MOIZAAsset.moizaConstGray1.color
        $0.layer.cornerRadius = 20
    }
    private let titleLabel = UILabel().then {
        $0.text = "ASDFASDFASDFASDFASDFASDFASDFASDFASDFASDFASFASDF"
        $0.numberOfLines = 0
    }
    private let postInfoLabel = UILabel().then {
        $0.text = "TEST"
    }
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = true
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    private let userInfoLabel = UILabel().then {
        $0.text = "TEST"
    }
    private let contentLabel = UILabel().then {
        $0.text = "TEST"
    }
    private let likeButton = UIButton().then {
        $0.setImage(.init(systemName: "heart"), for: .normal)
    }
    
    private let commentTableView = UITableView().then {
        $0.register(CommentCell.self, forCellReuseIdentifier: CommentCell.reusableID)
        $0.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(scrollView)
        scrollView.addSubViews(rootContainer)
    }
    override func setLayoutSubViews() {
        scrollView.pin.all()
        rootContainer.pin.top().width(100%)
        
        commentTableView.flex.height(commentTableView.contentSize.height)
        rootContainer.flex.layout(mode: .adjustHeight)
        scrollView.contentSize = rootContainer.frame.size
    }
    override func setLayout() {
        rootContainer.flex.define { flex in
            flex.addItem(headerContainer).define { flex in
                flex.addItem(titleLabel).marginTop(30).marginHorizontal(Metric.marginHorizontal)
                flex.addItem(postInfoLabel).marginTop(8).marginHorizontal(Metric.marginHorizontal)
                flex.addItem().direction(.row).marginHorizontal(Metric.marginHorizontal).define { flex in
                    flex.addItem(profileImageView).size(36)
                    flex.addItem(userInfoLabel)
                }
                flex.addItem(contentLabel).marginTop(30).marginHorizontal(Metric.marginHorizontal)
                flex.addItem(likeButton).marginTop(20).marginHorizontal(Metric.marginHorizontal)
            }
            flex.addItem(commentTableView).marginTop(82).grow(1).maxHeight(.infinity)
        }
        
    }
    
    // MARK: - UI
    override func configureNavigation() {
        self.navigationItem.configBack()
        self.navigationItem.setTitleWithSubTitle(
            title: UserDefaultsLocal.shared.major.display,
            subtitle: "질문 게시판"
        )
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: DetailPostReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: DetailPostReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        let commentDS = RxTableViewSectionedReloadDataSource<CommentSection> {_, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: CommentCell.reusableID, for: ip) as? CommentCell else { return .init() }
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.comments)
            .map{ [CommentSection.init(items: $0)] }
            .do(afterNext: { [weak self] _ in
                self?.view.setNeedsLayout()
            })
            .bind(to: commentTableView.rx.items(dataSource: commentDS))
            .disposed(by: disposeBag)
            
    }
}
