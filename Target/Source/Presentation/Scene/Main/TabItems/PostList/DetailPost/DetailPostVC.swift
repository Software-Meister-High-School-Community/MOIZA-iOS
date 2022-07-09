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
    private let ellipsisButton = UIBarButtonItem(image: .init(systemName: "ellipsis")?.tintColor(MOIZAAsset.moizaGray6.color),
                                                 style: .plain,
                                                 target: nil,
                                                 action: nil)
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
        $0.text = "작성일 언제"
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
    private let noCommentLabel = UILabel().then {
        $0.text = "아직 답글이 없네요!"
    }
    private let commentCountLabel = UILabel().then {
        let str = NSMutableAttributedString(string: "답글 0")
        str.setColorForText(textToFind: "답글", withColor: MOIZAAsset.moizaGray6.color)
        $0.text = "답글 2"
    }
    private let commentAddButton = UIButton().then {
        $0.setTitle("답글 추가", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray1.color, for: .normal)
        $0.backgroundColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.layer.cornerRadius = 16
    }
    private let commentTableView = UITableView().then {
        $0.register(CommentCell.self, forCellReuseIdentifier: CommentCell.reusableID)
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.commentTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.commentTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if object is UITableView {
                if let newValue = change?[.newKey] as? CGSize {
                    commentTableView.flex.height(newValue.height + 50)
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
            flex.addItem(headerContainer).marginTop(12).define { flex in
                flex.addItem(titleLabel).marginTop(30).marginHorizontal(Metric.marginHorizontal)
                flex.addItem(postInfoLabel).marginTop(8).marginHorizontal(Metric.marginHorizontal)
                flex.addItem().direction(.row).marginHorizontal(Metric.marginHorizontal).define { flex in
                    flex.addItem(profileImageView).size(36)
                    flex.addItem(userInfoLabel).marginLeft(12)
                }
                flex.addItem(contentLabel).marginTop(30).marginHorizontal(Metric.marginHorizontal)
                flex.addItem(likeButton).marginLeft(Metric.marginHorizontal).marginTop(20).marginBottom(25).alignSelf(.start)
            }
            flex.addItem().direction(.row).marginHorizontal(16).marginTop(40).define { flex in
                flex.addItem(commentCountLabel)
                flex.addItem().grow(1)
                flex.addItem(commentAddButton).height(32).width(80)
            }
            flex.addItem(commentTableView).marginTop(10).grow(1)
        }
        
    }
    
    // MARK: - UI
    override func configureNavigation() {
        self.navigationItem.configBack()
        self.navigationItem.setTitleWithSubTitle(
            title: UserDefaultsLocal.shared.major.display,
            subtitle: "질문 게시판"
        )
        self.navigationItem.rightBarButtonItem = ellipsisButton
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
            .bind(to: commentTableView.rx.items(dataSource: commentDS))
            .disposed(by: disposeBag)
            
    }
}
