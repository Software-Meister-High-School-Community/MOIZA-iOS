import PinLayout
import FlexLayout
import UIKit
import Then

final class AlarmVC: baseVC<AlarmReactor> {
    // MARK: - Metric
    enum Metric {
        static let marginHorizontal: CGFloat = 16
    }
    enum Font {
        static let categoryFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
    }
    enum Color {
        static let cateogryTextColor = MOIZAAsset.moizaGray6.color
    }
    
    // MARK: - Properties
    private let rootContainer = UIView()
    private let noticeLabel = UILabel().then {
        $0.text = "공지사항"
        $0.font = Font.categoryFont
        $0.textColor = Color.cateogryTextColor
    }
    private let allNoticeListButton = UIButton().then {
        $0.setTitle("전체 목록", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray4.color, for: .normal)
        $0.setImage(.init(systemName: "chevron.right")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    private let noticeView = NoticeView()
    private let notificationLabel = UILabel().then {
        $0.text = "알림"
        $0.font = Font.categoryFont
        $0.textColor = Color.cateogryTextColor
    }
    private let notificationTableView = UITableView()
    
    override func addView() {
        view.addSubViews(rootContainer)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.define { flex in
            flex.addItem().direction(.row).marginTop(18).marginHorizontal(Metric.marginHorizontal).define { flex in
                flex.addItem(noticeLabel)
                flex.addItem().grow(1)
                flex.addItem(allNoticeListButton)
            }
            flex.addItem(noticeView).marginTop(13).height(50).width(100%)
            flex.addItem(notificationLabel).marginTop(35).marginHorizontal(Metric.marginHorizontal)
            flex.addItem(notificationTableView).marginTop(13).grow(1)
        }
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    override func darkConfigure() {
        view.backgroundColor = MOIZAAsset.moizaDark1.color
    }
}
