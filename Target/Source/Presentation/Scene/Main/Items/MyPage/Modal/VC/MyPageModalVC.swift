import UIKit
import PinLayout
import FlexLayout
import PanModal
import RxSwift
import RxCocoa

final class MyPageModalVC: baseVC<MyPageModalReactor> {
    // MARK: - Properties
    private let options: [SortOption]
    private let rootContainer = UIView()
    private let headerLabel = UILabel().then {
        $0.text = "정렬"
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
    }
    private let resetButton = UIButton().then {
        $0.setUnderline()
        $0.setTitle("초기화", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaConstGray4.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
    }
    private let postTypeSegment = SortModalSegmentedControl(titles: ["전체", "질문", "일반"]).then {
        $0.borderColor = MOIZAAsset.moizaGray3.color
    }
    private let separatorFirst = UIView().then {
        $0.backgroundColor = MOIZAAsset.moizaGray3.color
    }
    private let sortTypeSegment = SortModalSegmentedControl(titles: ["최신순", "좋아요순", "오래된순", "조회순"]).then {
        $0.borderColor = MOIZAAsset.moizaGray3.color
    }
    private let majorPicker = UIPickerView()
    private let majorTextField = UITextField().then {
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.leftSpace(14)
        $0.addRightImage(image: .init(systemName: "chevron.down")?.tintColor(MOIZAAsset.moizaConstGray4.color) ?? .init())
    }
    private let separatorSecond = UIView().then {
        $0.backgroundColor = MOIZAAsset.moizaGray3.color
    }
    private let applyButton = UIButton().then {
        $0.titleLabel?.textAlignment = .center
        $0.setTitle("적용하기", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaConstGray1.color, for: .normal)
        $0.backgroundColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.layer.cornerRadius = 5
    }
    
    init(_ options: [SortOption], reactor: MyPageModalReactor?) {
        self.options = options
        super.init(reactor: reactor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    override func setUp() {
        majorTextField.inputView = majorPicker
        [postTypeSegment, sortTypeSegment].forEach{ $0.delegate = self }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if options.contains(.major) { panModalTransition(to: .longForm) }
    }
    override func addView() {
        view.addSubViews(rootContainer)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.marginHorizontal(17).define { flex in
            flex.addItem().direction(.row).marginVertical(25).width(100%).define { flex in
                flex.addItem(headerLabel)
                flex.addItem().grow(1)
                flex.addItem(resetButton)
            }
            flex.addItem(postTypeSegment).width(100%).height(35).display(options.contains(.postType) ? .flex : .none)
            flex.addItem(separatorFirst).height(0.5).marginVertical(14).display(options.contains(.postType) ? .flex : .none)
            flex.addItem(sortTypeSegment).width(100%).marginBottom(20).height(35).display(options.contains(.sortType) ? .flex : .none)
            flex.addItem(majorTextField).width(100%).height(50).display(options.contains(.major) ? .flex : .none)
            flex.addItem().grow(1).display(options.contains(.major) ? .flex : .none)
            flex.addItem(majorPicker).height(100)
            flex.addItem(separatorSecond).height(0.5).marginTop(240)
            flex.addItem(applyButton).height(50).width(100%).marginTop(15).marginBottom(10)
        }
    }
    override func darkConfigure() {
        view.backgroundColor = MOIZAAsset.moizaDark2.color
        [postTypeSegment, sortTypeSegment].forEach{
            $0.borderColor = .clear
            $0.unselectedBackgroundColor = MOIZAAsset.moizaDark3.color
        }
        majorTextField.layer.borderColor = UIColor.clear.cgColor
        majorTextField.backgroundColor = MOIZAAsset.moizaDark3.color
    }
    
    // MARK: - Reactor
    override func bindView(reactor: MyPageModalReactor) {
        majorPicker.rx.itemSelected
            .map(\.row)
            .map { Major.allCases[$0] }
            .map(Reactor.Action.majorPickerDidSet)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        applyButton.rx.tap
            .map { Reactor.Action.applyButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: MyPageModalReactor) {
        let sharedState = reactor.state.share(replay: 2)
        
        sharedState
            .map(\.sortType)
            .map{
                switch $0 {
                case .latest: return 0
                case .like: return 1
                case .old: return 2
                case .view: return 3
                }
            }
            .bind(to: sortTypeSegment.rx.selectedIndex)
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.major)
            .map(\.rawValue)
            .bind(to: majorTextField.rx.text)
            .disposed(by: disposeBag)
        
        Observable.just(Major.allCases)
            .bind(to: majorPicker.rx.itemTitles) { _, item in
                return "\(item.rawValue)"
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - PanModal
extension MyPageModalVC: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(551)
    }
    var longFormHeight: PanModalHeight {
        return .contentHeight(551)
    }
    var cornerRadius: CGFloat {
        return 10
    }
}

// MARK: - SortModalSegmentedControlDelegate
extension MyPageModalVC: SortModalSegmentedControlDelegate {
    func segmentValueChanged(to index: Int, sender: SortModalSegmentedControl) {
        if sender == sortTypeSegment {
            var sort: SortType = .latest
            switch index {
            case 0:
                sort = .latest
            case 1:
                sort = .like
            case 2:
                sort = .old
            case 3:
                sort = .view
            default:
                sort = .latest
            }
            reactor?.action.onNext(.sortTypeSegDidTap(sort))
        }
    }
}
