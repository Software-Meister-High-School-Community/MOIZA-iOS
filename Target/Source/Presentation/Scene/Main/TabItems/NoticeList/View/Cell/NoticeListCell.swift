import UIKit
import Then
import PinLayout
import FlexLayout

final class NoticeListCell: BaseTableViewCell<NoticeList> {
    // MARK: - Metric
    enum Metric {
        static let marginHorizontal: CGFloat = 14
    }
    enum Font {
        static let titleLabelFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
        static let dateLabelFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 10)
    }
    enum Color {
        static let titleLabelTextColor = MOIZAAsset.moizaGray6.color
        static let dateLabelTextColor = MOIZAAsset.moizaGray4.color
    }
    
    // MARK: - Properties
    private let rootContainer = UIView().then {
        $0.layer.cornerRadius = 5
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    private let titleLabel = UILabel().then {
        $0.font = Font.titleLabelFont
        $0.textColor = Color.titleLabelTextColor
    }
    private let dateLabel = UILabel().then {
        $0.font = Font.dateLabelFont
        $0.textColor = Color.dateLabelTextColor
    }
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(rootContainer)
    }
    override func setLayoutSubviews() {
        rootContainer.pin.all()
        
        rootContainer.flex.layout(mode: .adjustHeight)
    }
    override func setLayout() {
        rootContainer.flex.marginVertical(10).marginHorizontal(16).define { flex in
            flex.addItem(titleLabel).marginTop(14).marginHorizontal(Metric.marginHorizontal)
            flex.addItem(dateLabel).marginTop(10).marginBottom(14).marginHorizontal(Metric.marginHorizontal)
        }
    }
    override func configureCell() {
        self.backgroundColor = .clear
        selectionStyle = .none
    }
    override func darkConfigure() {
        rootContainer.backgroundColor = MOIZAAsset.moizaDark2.color
        dateLabel.textColor = MOIZAAsset.moizaDark4.color
    }
    
    override func bind(_ model: NoticeList) {
        titleLabel.text = model.title
        dateLabel.text = "\(model.createdAt.year)/\(model.createdAt.month)/\(model.createdAt.day) \(model.createdAt.hour):\(model.createdAt.minute)"
    }
}
