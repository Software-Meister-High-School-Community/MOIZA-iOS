
import UIKit
import RxDataSources
import RxSwift
import RxViewController
import PinLayout
import RxCocoa
import FlexLayout
import Then

final class MyPageVC: baseVC<MyPageReactor> {
    // MARK: - Metric
    enum Metric {
        static let marginHorizontal: CGFloat = 16
    }
    //MARK: - Properties
    private let rootContainer = UIView()
    private let scrollView = UIScrollView()
    private let profileContainer = UIView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.backgroundColor = .white
    }
    private let profileBackgroundColorView = UIView().then {
        $0.backgroundColor = .orange
    }
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 50
        $0.backgroundColor = .gray
    }
    private let nameLabel = UILabel().then {
        $0.text = "최형우"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 18)
    }
    private let schoolLabel = UILabel().then {
        $0.text = "어디학교 재학생"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 13)
    }
    private let postLabel = UILabel().then {
        $0.text = "게시물"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
    }
    private let postCountLabel = UILabel().then {
        $0.text = "2353"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 12)
    }
    private let followerLabel = UILabel().then {
        $0.text = "팔로워"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
    }
    private let followerCountLabel = UILabel().then {
        $0.text = "24"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 12)
    }
    private let followingLabel = UILabel().then {
        $0.text = "팔로잉"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
    }
    private let followingCountLabel = UILabel().then {
        $0.text = "532"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 12)
    }
    private let introContaier = UIView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.backgroundColor = .white
    }
    private let introLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 13)
    }
    private let linkTextView = UITextView().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.textColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.dataDetectorTypes = .link
        $0.isEditable = false
        $0.isScrollEnabled = false
    }
    private let myPostLabel = UILabel().then {
        $0.text = "나의 게시물"
    }
    private let sortButton = SortButton()
    private let myPostListTableView = UITableView().then {
        $0.register(PostCell.self, forCellReuseIdentifier: PostCell.reusableID)
        $0.rowHeight = 60
        $0.separatorStyle = .none
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
        $0.isScrollEnabled = false
    }
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myPostListTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        myPostListTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if object is UITableView {
                if let newValue = change?[.newKey] as? CGSize {
                    myPostListTableView.flex.height(newValue.height + 30)
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
        rootContainer.flex.paddingHorizontal(Metric.marginHorizontal).define { flex in
            flex.addItem(profileContainer).define { flex in
                flex.addItem(profileBackgroundColorView).width(100%).height(99)
                flex.addItem().direction(.row).marginBottom(30).grow(1).define { flex in
                    flex.addItem(profileImageView).marginLeft(10).size(100).marginTop(-22)
                    flex.addItem().marginHorizontal(20).grow(3).define { flex in
                        flex.addItem(nameLabel).marginTop(8)
                        flex.addItem(schoolLabel).marginTop(8)
                        flex.addItem().direction(.row).justifyContent(.spaceBetween).marginTop(20).define { flex in
                            flex.addItem().alignItems(.center).define { flex in
                                flex.addItem(postLabel)
                                flex.addItem(postCountLabel).marginTop(5)
                            }
                            flex.addItem().alignItems(.center).define { flex in
                                flex.addItem(followerLabel)
                                flex.addItem(followerCountLabel).marginTop(5)
                            }
                            flex.addItem().alignItems(.center).define { flex in
                                flex.addItem(followingLabel)
                                flex.addItem(followingCountLabel).marginTop(5)
                            }
                        }
                    }
                }
            }
            flex.addItem(introContaier).marginTop(12).define { flex in
                flex.addItem(introLabel).marginHorizontal(14).marginTop(20)
                flex.addItem(linkTextView).marginTop(8).marginHorizontal(14).marginBottom(20)
            }
            flex.addItem().marginTop(40).direction(.row).define { flex in
                flex.addItem(myPostLabel)
                flex.addItem().grow(1)
                flex.addItem(sortButton)
            }
            flex.addItem(myPostListTableView).marginTop(20).grow(1)
        }
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    override func configureNavigation() {
        self.navigationItem.configLeftLogo()
        self.navigationItem.configBack()
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: MyPageReactor) {
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindView(reactor: MyPageReactor) {
        
    }
    override func bindState(reactor: MyPageReactor) {
        let sharedState = reactor.state.share(replay: 2).observe(on: MainScheduler.asyncInstance)
        
        let postDS = RxTableViewSectionedReloadDataSource<PostSection> { _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: PostCell.reusableID) as? PostCell else { return .init() }
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.postItems)
            .map { [PostSection.init(header: "", items: $0)] }
            .bind(to: myPostListTableView.rx.items(dataSource: postDS))
            .disposed(by: disposeBag)
        
        sharedState
            .compactMap(\.profile)
            .bind(with: self) { owner, profile in
                owner.nameLabel.text = profile.name
                owner.schoolLabel.text = "\(profile.school.display) \(profile.scope.display)"
                owner.postCountLabel.text = "\(profile.feedCount)"
                owner.followerCountLabel.text = "\(profile.followerCount)"
                owner.followingCountLabel.text = "\(profile.followingCount)"
                owner.introLabel.text = profile.introduce ?? "자기소개가 없습니다!"
                owner.linkTextView.text = profile.linkUrl?.joined(separator: "\n")
                owner.introLabel.flex.markDirty()
                owner.linkTextView.flex.markDirty()
                owner.rootContainer.flex.layout(mode: .adjustHeight)
            }
            .disposed(by: disposeBag)
    }
}
