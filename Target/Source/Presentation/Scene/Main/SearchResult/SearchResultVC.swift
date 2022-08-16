import UIKit
import Then
import PinLayout
import FlexLayout
import RxSwift
import RxCocoa

final class SearchResultVC: baseVC<SearchResultReactor> {
    // MARK: - Metric
    enum Metric {
        static let marginHorizontal: CGFloat = 16
    }
    enum Font {
        static let categoryTitleFont = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 16)
        static let searchResLabel = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
    }
    enum Color {
        static let categoryTitleTextColor = MOIZAAsset.moizaGray6.color
        static let searchResTextColor = MOIZAAsset.moizaGray6.color
    }
    
    // MARK: - Properties
    private let rootContainer = UIView()
    private let searchResultCountLabel = UILabel().then {
        $0.font = Font.searchResLabel
        $0.textColor = Color.searchResTextColor
    }
    private let userLabel = UILabel().then {
        $0.text = "유저"
        $0.font = Font.categoryTitleFont
        $0.textColor = Color.categoryTitleTextColor
    }
    private let userCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 112, height: 167)
        $0.collectionViewLayout = layout
        $0.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reusableID)
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    private let postLabel = UILabel().then {
        $0.text = "게시물"
        $0.font = Font.categoryTitleFont
        $0.textColor = Color.categoryTitleTextColor
    }
    private let sortButton = SortButton()
    private let postTableView = UITableView().then {
        $0.register(PostCell.self, forCellReuseIdentifier: PostCell.reusableID)
        $0.separatorStyle = .none
        $0.rowHeight = 60
        $0.backgroundColor = .clear
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(rootContainer)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.marginHorizontal(Metric.marginHorizontal).define { flex in
            flex.addItem(searchResultCountLabel).marginTop(20)
            flex.addItem(userLabel).marginTop(38)
            flex.addItem(userCollectionView).height(167).width(100%).marginTop(10)
            flex.addItem().direction(.row).marginTop(38).define { flex in
                flex.addItem(postLabel)
                flex.addItem().grow(1)
                flex.addItem(sortButton)
            }
            flex.addItem(postTableView).grow(1).marginTop(10)
        }
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    override func configureNavigation() {
        self.navigationItem.configBack()
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: SearchResultReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindView(reactor: SearchResultReactor) {
        postTableView.rx.modelSelected(PostList.self)
            .map(\.id)
            .map(Reactor.Action.postDidTap)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: SearchResultReactor) {
        let sharedState = reactor.state.share(replay: 3).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.users)
            .bind(to: userCollectionView.rx.items(cellIdentifier: UserCell.reusableID, cellType: UserCell.self)) { _, item, cell in
                cell.model = item
            }
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.posts)
            .bind(to: postTableView.rx.items(cellIdentifier: PostCell.reusableID, cellType: PostCell.self)) { _, item, cell in
                cell.model = item
            }
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.keyword)
            .distinctUntilChanged()
            .bind(with: self) { owner, key in
                owner.searchResultCountLabel.attributedText = NSMutableAttributedString(string: "\(key)에 대한 검색결과는 총 0건 입니다.")
                    .setColorForText(textToFind: key, withColor: MOIZAAsset.moizaPrimaryBlue.color)
            }
            .disposed(by: disposeBag)
    }
}
