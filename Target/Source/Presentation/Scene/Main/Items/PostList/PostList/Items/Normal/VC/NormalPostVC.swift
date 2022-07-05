import UIKit
import PinLayout
import FlexLayout
import RxSwift
import RxCocoa
import RxDataSources

final class NormalPostVC: baseVC<PostListReactor> {
    // MARK: - Metric
    enum Metric {
        static let marginHorizontal: CGFloat = 16
    }
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let rootContainer = UIView()
    private let recommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 200, height: 150)
        $0.showsHorizontalScrollIndicator = false
        $0.register(RecommendCell.self, forCellWithReuseIdentifier: RecommendCell.reusableID)
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
    }
    private let headerLabel = UILabel().then {
        $0.text = "모든 게시물"
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 18)
    }
    private let sortButton = SortButton()
    private let postListTableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(PostCell.self, forCellReuseIdentifier: PostCell.reusableID)
        $0.rowHeight = 60
        $0.separatorStyle = .none
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
        $0.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postListTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        postListTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if object is UITableView {
                if let newValue = change?[.newKey] as? CGSize {
                    postListTableView.flex.height(newValue.height + 30)
                    rootContainer.flex.layout(mode: .adjustHeight)
                    scrollView.contentSize = rootContainer.frame.size
                }
            }
        }
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(scrollView)
        scrollView.addSubViews(rootContainer)
    }
    override func setLayoutSubViews() {
        scrollView.pin.all(view.pin.safeArea)
        rootContainer.pin.top().width(100%)
        
        rootContainer.flex.layout(mode: .adjustHeight)
        scrollView.contentSize = rootContainer.frame.size
    }
    override func setLayout() {
        rootContainer.flex.define { flex in
            flex.addItem().height(175).define { flex in
                flex.addItem(recommendCollectionView).marginHorizontal(Metric.marginHorizontal).height(175)
            }
            flex.addItem().direction(.row).marginTop(30).marginHorizontal(Metric.marginHorizontal).define { flex in
                flex.addItem(headerLabel)
                flex.addItem().grow(1)
                flex.addItem(sortButton)
            }
            flex.addItem(postListTableView).marginTop(29).marginHorizontal(Metric.marginHorizontal).grow(1)
        }
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    override func darkConfigure() {
        view.backgroundColor = MOIZAAsset.moizaDark1.color
        postListTableView.backgroundColor = MOIZAAsset.moizaDark1.color
    }
    
    // MARK: - Reactor
    override func bindView(reactor: PostListReactor) {
        scrollView.rx.reachedBottom(offset: 75)
            .map { Reactor.Action.reachedBottom(.normal) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        sortButton.rx.tap
            .map { Reactor.Action.sortButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindAction(reactor: PostListReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    override func bindState(reactor: PostListReactor) {
        let sharedState = reactor.state.share(replay: 2).observe(on: MainScheduler.asyncInstance)
        
        let recommendDS = RxCollectionViewSectionedReloadDataSource<RecommendSection> { _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: RecommendCell.reusableID, for: ip) as? RecommendCell else { return .init() }
            cell.model = item
            cell.backgroundColor = (ip.row+1)%2 != 0 ? MOIZAAsset.moizaPrimaryBlue.color : .init(red: 0, green: 0.5213, blue: 1, alpha: 1)
            return cell
        }
        
        let postDS = RxTableViewSectionedReloadDataSource<PostSection> { _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: PostCell.reusableID) as? PostCell else { return .init() }
            cell.model = item
            return cell
        }
        
        sharedState
            .compactMap { $0.recommendItems[.normal] }
            .map { [RecommendSection.init(header: "", items: $0)] }
            .bind(to: recommendCollectionView.rx.items(dataSource: recommendDS))
            .disposed(by: disposeBag)
        
        sharedState
            .compactMap { $0.postItems[.normal] }
            .ifEmpty(default: [])
            .map { [PostSection.init(header: "", items: $0)] }
            .bind(to: postListTableView.rx.items(dataSource: postDS))
            .disposed(by: disposeBag)
        
    }
}
