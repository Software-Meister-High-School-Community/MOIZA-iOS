import UIKit
import Then
import PinLayout
import FlexLayout
import RxSwift
import RxCocoa

protocol RecentSearchCellDelegate: AnyObject {
    func removeButtonDidTap(id: String)
}

final class RecentSearchCell: baseTableViewCell<RecentSearch> {
    // MARK: - Metric
    enum Metric {
        
    }
    enum Font {
        static let keywordFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
    }
    enum Color {
        static let keywordTextColor = MOIZAAsset.moizaGray6.color
        static let removeButtonImageColor = MOIZAAsset.moizaGray4.color
    }
    
    // MARK: - Properties
    weak var delegate: RecentSearchCellDelegate?
    private let rootContainer = UIView().then {
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    private let keywordLabel = UILabel().then {
        $0.font = Font.keywordFont
        $0.textColor = Color.keywordTextColor
    }
    private let removeButton = UIButton().then {
        $0.setImage(.init(systemName: "xmark")?.tintColor(Color.removeButtonImageColor), for: .normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
        disposeBag = DisposeBag()
    }
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(rootContainer)
    }
    override func setLayoutSubviews() {
        rootContainer.pin.all().height(40)
        
        rootContainer.flex.layout()
        contentView.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.direction(.row).marginHorizontal(16).define { flex in
            flex.addItem(keywordLabel).marginLeft(14).width(75%)
            flex.addItem().grow(1)
            flex.addItem(removeButton).marginRight(12)
        }
    }
    override func configureCell() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        self.selectionStyle = .none
    }
    override func darkConfigure() {
        rootContainer.backgroundColor = MOIZAAsset.moizaDark2.color
    }
    override func bind(_ model: RecentSearch) {
        keywordLabel.text = model.keyword
        
        removeButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.delegate?.removeButtonDidTap(id: model.id)
            }
            .disposed(by: disposeBag)
    }
}
