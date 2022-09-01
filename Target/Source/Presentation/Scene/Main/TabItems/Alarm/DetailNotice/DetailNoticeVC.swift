import UIKit
import PinLayout
import FlexLayout
import Then
import RxSwift
import RxCocoa

final class DetailNoticeVC: BaseVC<DetailNoticeReactor> {
    // MARK: - Metric
    enum Metric {
        static let marginHorizontal: CGFloat = 16
    }
    enum Font {
        static let titleLabelFont = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 18)
        static let dateLabelFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 10)
        static let contentLabelFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
    }
    enum Color {
        static let titleLabelTextColor = MOIZAAsset.moizaGray6.color
        static let dateLabelTextColor = MOIZAAsset.moizaGray4.color
        static let contentLabelTextColor = MOIZAAsset.moizaGray5.color
    }
    
    // MARK: - Properties
    private let rootContainer = UIView().then {
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel().then {
        $0.font = Font.titleLabelFont
        $0.textColor = Color.titleLabelTextColor
    }
    private let dateLabel = UILabel().then {
        $0.font = Font.dateLabelFont
        $0.textColor = Color.dateLabelTextColor
    }
    private let separatorView = UIView().then {
        $0.backgroundColor = MOIZAAsset.moizaGray3.color
    }
    private let contentLabel = UILabel().then {
        $0.font = Font.contentLabelFont
        $0.textColor = Color.contentLabelTextColor
        $0.numberOfLines = 0
        $0.baselineAdjustment = .alignBaselines
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
            flex.addItem(titleLabel).marginTop(23).marginHorizontal(Metric.marginHorizontal)
            flex.addItem(dateLabel).marginTop(8).marginHorizontal(Metric.marginHorizontal)
            flex.addItem(separatorView).marginTop(10).marginHorizontal(Metric.marginHorizontal).height(0.5)
            flex.addItem(contentLabel).marginTop(20).marginHorizontal(Metric.marginHorizontal)
        }
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    override func configureNavigation() {
        self.navigationItem.setTitle(title: "공지사항")
    }
    override func darkConfigure() {
        view.backgroundColor = MOIZAAsset.moizaDark1.color
        rootContainer.backgroundColor = MOIZAAsset.moizaDark2.color
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: DetailNoticeReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: DetailNoticeReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .compactMap(\.notice)
            .bind(with: self) { owner, notice in
                owner.titleLabel.text = notice.title
                owner.titleLabel.flex.markDirty()
                
                owner.dateLabel.text = "\(notice.createdAt.year)/\(notice.createdAt.month)/\(notice.createdAt.day) \(notice.createdAt.hour):\(notice.createdAt.minute)"
                owner.dateLabel.flex.markDirty()
                
                owner.contentLabel.text = notice.content
                owner.contentLabel.flex.markDirty()
                
                owner.rootContainer.flex.minHeight(owner.bound.height).layout(mode: .adjustHeight)
                owner.scrollView.contentSize = owner.rootContainer.frame.size
            }
            .disposed(by: disposeBag)
    }
}
