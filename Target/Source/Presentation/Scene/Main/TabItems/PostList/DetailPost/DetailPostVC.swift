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
    enum Font {
        static let postTitleFont = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 18)
        static let postInfoFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 10)
        static let userInfoFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        static let contentFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        static let heartButtonFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        static let noCommentFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
        static let commentCountFont = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 20)
        static let commentButtonFont = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 14)
    }
    enum Color {
        static let postTitleTextColor = MOIZAAsset.moizaGray6.color
        static let postInfoTextColor = MOIZAAsset.moizaGray4.color
        static let userInfoTextColor = MOIZAAsset.moizaGray4.color
        static let userNameTextColor = MOIZAAsset.moizaGray6.color
        static let contentTextColor = MOIZAAsset.moizaGray6.color
        static let heartButtonTextColor = MOIZAAsset.moizaGray4.color
        static let noCommentTextColor = MOIZAAsset.moizaGray4.color
        static let commentCountTextColor = MOIZAAsset.moizaGray6.color
        static let commentCountHighlightTextColor = MOIZAAsset.moizaPrimaryBlue.color
        static let commentButtonTextColor = MOIZAAsset.moizaConstGray1.color
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
        $0.layer.cornerRadius = 20
    }
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = Font.postTitleFont
        $0.textColor = Color.postTitleTextColor
    }
    private let postInfoLabel = UILabel().then {
        $0.font = Font.postInfoFont
        $0.textColor = Color.postInfoTextColor
    }
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = true
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    private let userInfoLabel = UILabel().then {
        $0.font = Font.userInfoFont
        $0.textColor = Color.userInfoTextColor
    }
    private let contentLabel = UILabel().then {
        $0.font = Font.contentFont
        $0.textColor = Color.contentTextColor
        $0.numberOfLines = 0
    }
    private let likeButton = UIButton().then {
        $0.setImage(.init(systemName: "heart")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
        $0.setTitleColor(Color.heartButtonTextColor, for: .normal)
        $0.titleLabel?.font = Font.heartButtonFont
    }
    private let noCommentLabel = UILabel().then {
        $0.text = "아직 답글이 없네요!"
        $0.font = Font.noCommentFont
        $0.textColor = Color.noCommentTextColor
    }
    private let commentCountLabel = UILabel().then {
        $0.text = "답글 2"
        $0.font = Font.commentCountFont
        $0.textColor = Color.commentCountTextColor
    }
    private let commentAddButton = UIButton().then {
        $0.setTitle("답글 추가", for: .normal)
        $0.setTitleColor(Color.commentButtonTextColor, for: .normal)
        $0.backgroundColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.layer.cornerRadius = 16
        $0.titleLabel?.font = Font.commentButtonFont
    }
    private let commentTableView = UITableView().then {
        $0.register(CommentCell.self, forCellReuseIdentifier: CommentCell.reusableID)
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
    }
    
    // MARK: - Menu Action
    private lazy var reportMenu = UIAction(title: "신고") { [weak self] _ in
        self?.reactor?.action.onNext(.reportMenuDidTap)
    }
    private lazy var updateMenu = UIAction(title: "수정") { [weak self] _ in
        self?.reactor?.action.onNext(.updateMenuDidTap)
    }
    private lazy var deleteMenu = UIAction(title: "삭제", attributes: .destructive) { [weak self] _ in
        self?.reactor?.action.onNext(.deleteMenuDidTap)
    }
    
    // MARK: - Lifecycle
    
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
                flex.addItem().direction(.row).marginTop(12).marginHorizontal(Metric.marginHorizontal).define { flex in
                    flex.addItem(profileImageView).size(36)
                    flex.addItem(userInfoLabel).marginLeft(12)
                }
                flex.addItem(contentLabel).marginTop(30).marginHorizontal(Metric.marginHorizontal)
                flex.addItem(likeButton).marginLeft(Metric.marginHorizontal).marginTop(20).marginBottom(25).alignSelf(.start)
            }
            flex.addItem().direction(.row).marginHorizontal(Metric.marginHorizontal).marginTop(40).define { flex in
                flex.addItem(commentCountLabel)
                flex.addItem().grow(1)
                flex.addItem(commentAddButton).height(32).width(80)
            }
            flex.addItem(noCommentLabel).alignSelf(.center).marginTop(30).display(.none)
            flex.addItem(commentTableView).marginTop(10).grow(1)
        }
        
    }
    
    // MARK: - UI
    override func configureNavigation() {
        self.navigationItem.configBack()
        self.navigationItem.rightBarButtonItem = ellipsisButton
    }
    override func configureVC() {
        headerContainer.backgroundColor = MOIZAAsset.moizaConstGray1.color
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    
    override func darkConfigure() {
        rootContainer.backgroundColor = MOIZAAsset.moizaDark1.color
        view.backgroundColor = MOIZAAsset.moizaDark1.color
        headerContainer.backgroundColor = MOIZAAsset.moizaDark2.color
        scrollView.backgroundColor = .clear
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: DetailPostReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: DetailPostReactor) {
        let sharedState = reactor.state.share(replay: 2).observe(on: MainScheduler.asyncInstance)
        
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
        
        sharedState
            .compactMap(\.post)
            .bind(with: self) { owner, post in
                owner.titleLabel.text = post.title
                owner.postInfoLabel.text = "작성일 \(post.createdAt.year)/\(post.createdAt.month)/\(post.createdAt.day) | 조회수 \(post.viewCount)회"
                owner.profileImageView.kf.setImage(with: URL(string: post.author.profileImageUrl), placeholder: UIImage(systemName: "person"))
                owner.userInfoLabel.attributedText = NSMutableAttributedString()
                    .text("\(post.author.name) • \(post.author.schoolName.display) • \(post.author.type.display)")
                    .setColorForText(textToFind: post.author.name, withColor: Color.userNameTextColor)
                owner.contentLabel.text = post.content
                owner.likeButton.setTitle("\(post.likeCount)", for: .normal)
                owner.commentCountLabel.attributedText = NSMutableAttributedString()
                    .text("답글 \(post.comments.count)")
                    .font(Font.commentCountFont)
                    .setColorForText(textToFind: "\(post.comments.count)", withColor: Color.commentCountHighlightTextColor)
                if post.comments.count == .zero {
                    owner.noCommentLabel.flex.display(.flex)
                }
                owner.ellipsisButton.menu = UIMenu(
                    title: "",
                    options: .displayInline,
                    children: post.isMine ? [owner.updateMenu, owner.deleteMenu] : [owner.reportMenu]
                )
                owner.navigationItem.setTitleWithSubTitle(
                    title: UserDefaultsLocal.shared.major.display,
                    subtitle: "\(post.feedType.display) 게시판"
                )
                
                [
                    owner.likeButton, owner.titleLabel, owner.postInfoLabel, owner.userInfoLabel, owner.contentLabel,
                    owner.likeButton, owner.commentCountLabel
                ].forEach { $0.flex.markDirty() }
                owner.rootContainer.flex.layout(mode: .adjustHeight)
            }
            .disposed(by: disposeBag)
            
    }
}
