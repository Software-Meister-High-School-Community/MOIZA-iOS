import UIKit
import PanModal
import PinLayout
import RxDataSources
import RxSwift

final class MajorModalVC: BaseVC<MajorModalReactor> {
    // MARK: - Properties
    private let closeButton = UIButton().then {
        $0.setImage(.init(systemName: "xmark")?.tintColor(MOIZAAsset.moizaGray6.color), for: .normal)
    }
    private let titleLabel = UILabel().then {
        $0.text = "커뮤니티 전공 카테고리를 선택해주세요!"
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
    }
    private let majorTableView = UITableView().then {
        $0.register(MajorCell.self, forCellReuseIdentifier: MajorCell.reusableID)
        $0.rowHeight = 40
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(titleLabel, closeButton, majorTableView)
    }
    override func setLayoutSubViews() {
        closeButton.pin.topRight(12).size(30)
        titleLabel.pin.below(of: closeButton).marginTop(5).pinEdges().horizontally(16).height(30).width(90%)
        majorTableView.pin.below(of: titleLabel).marginHorizontal(16).bottom(0).width(100%)
    }
    override func configureVC() {
        let majorDS = RxTableViewSectionedReloadDataSource<MajorSection> { _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: MajorCell.reusableID, for: ip) as? MajorCell else { return .init() }
            cell.model = item
            return cell
        }
        
        Observable.just(Major.allCases)
            .map { [MajorSection(header: "", items: $0)] }
            .bind(to: majorTableView.rx.items(dataSource: majorDS))
            .disposed(by: disposeBag)
    }
    override func darkConfigure() {
        view.backgroundColor = MOIZAAsset.moizaDark2.color
    }
    
    // MARK: - Reactor
    override func bindView(reactor: MajorModalReactor) {
        majorTableView.rx.modelSelected(Major.self)
            .map(Reactor.Action.majorDidTap)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        closeButton.rx.tap
            .map { Reactor.Action.closeButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

// MARK: - PanModal
extension MajorModalVC: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return majorTableView
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(bound.height*0.6)
    }
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(bound.height*0.2)
    }
    var cornerRadius: CGFloat {
        return 10
    }
}
