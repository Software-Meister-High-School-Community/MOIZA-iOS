import UIKit
import PinLayout
import FlexLayout
import Foundation
import Then
import RxSwift
import RxCocoa
import RxDataSources

final class SearchVC: BaseVC<SearchReactor> {
    // MARK: - Metrict
    enum Metric {
        static let marginHorizontal: CGFloat = 16
    }
    enum Font {
        static let recentSearchTextFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        static let allRemoveButtonFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        static let searchTextFieldFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
    }
    enum Color {
        static let searchTextFieldBorderColor = MOIZAAsset.moizaPrimaryBlue.color
        static let recentSearchTextColor = MOIZAAsset.moizaGray4.color
        static let allRemoveButtonTextColor = MOIZAAsset.moizaGray4.color
    }
    
    // MARK: - Properties
    private let rootContainer = UIView()
    private let searchTextField = UITextField().then {
        $0.placeholder = "검색어를 입력하세요"
        $0.layer.borderWidth = 3
        $0.layer.borderColor = Color.searchTextFieldBorderColor.cgColor
        $0.layer.cornerRadius = 5
        $0.leftSpace(14)
        $0.font = Font.searchTextFieldFont
    }
    private let searchButton = UIButton().then {
        $0.setImage(.init(systemName: "magnifyingglass")?.tintColor(MOIZAAsset.moizaConstGray1.color), for: .normal)
        $0.backgroundColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    private let recentSearchLabel = UILabel().then {
        $0.text = "최근 검색어"
        $0.font = Font.recentSearchTextFont
        $0.textColor = Color.recentSearchTextColor
    }
    private let allRemoveButton = UIButton().then {
        $0.setTitle("전체삭제", for: .normal)
        $0.setTitleColor(Color.allRemoveButtonTextColor, for: .normal)
        $0.titleLabel?.font = Font.allRemoveButtonFont
    }
    private let recentSearchTableView = UITableView().then {
        $0.register(RecentSearchCell.self, forCellReuseIdentifier: RecentSearchCell.reusableID)
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.rowHeight = 46
    }
    
    // MARK: - UI
    override func setUp() {
        searchButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        searchTextField.rightView = searchButton
        searchTextField.rightViewMode = .always
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
            flex.addItem(searchTextField).marginTop(20).marginHorizontal(Metric.marginHorizontal).height(45)
            flex.addItem().direction(.row).marginTop(47).marginHorizontal(Metric.marginHorizontal).define { flex in
                flex.addItem(recentSearchLabel)
                flex.addItem().grow(1)
                flex.addItem(allRemoveButton)
            }
            flex.addItem(recentSearchTableView).marginTop(10).grow(1)
        }
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    override func darkConfigure() {
        view.backgroundColor = MOIZAAsset.moizaDark1.color
    }
    override func configureNavigation() {
        self.navigationItem.setTitle(title: "검색")
        self.navigationItem.configBack()
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: SearchReactor) {
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindView(reactor: SearchReactor) {
        allRemoveButton.rx.tap
            .map { Reactor.Action.allRemoveButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        recentSearchTableView.rx.modelSelected(RecentSearch.self)
            .map(\.keyword)
            .map(Reactor.Action.recentSearchKeywordDidTap(keyword:))
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchTextField.rx.text.orEmpty
            .map(Reactor.Action.updateSearchTextField)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .map { Reactor.Action.searchBarDidCommit }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchButton.rx.tap
            .map { Reactor.Action.searchBarDidCommit }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: SearchReactor) {
        let sharedState = reactor.state.share(replay: 2).observe(on: MainScheduler.asyncInstance)
        
        let recentSearchDS = RxTableViewSectionedReloadDataSource<RecentSearchSection> { [weak self] _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: RecentSearchCell.reusableID, for: ip) as? RecentSearchCell else { return .init() }
            cell.model = item
            cell.delegate = self
            return cell
        }
        
        sharedState
            .map(\.searchText)
            .bind(to: searchTextField.rx.text)
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.recentSeachList)
            .map { [RecentSearchSection.init(items: $0)] }
            .bind(to: recentSearchTableView.rx.items(dataSource: recentSearchDS))
            .disposed(by: disposeBag)
    }
}

extension SearchVC: RecentSearchCellDelegate {
    func removeButtonDidTap(id: String) {
        self.reactor?.action.onNext(.recentSearchRemoveButtonDidTap(id: id))
    }
}
