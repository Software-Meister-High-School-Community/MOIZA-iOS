import UIKit
import PinLayout
import FlexLayout
import Then

final class NotificationCell: BaseTableViewCell<NotificationList> {
    private let rootContainer = UIView()
    private let notificationLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.textColor = MOIZAAsset.moizaGray5.color
    }
    
    override func addView() {
        contentView.addSubViews(rootContainer)
    }
    override func setLayoutSubviews() {
        rootContainer.pin.all()
        
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.define { flex in
            flex.addItem(notificationLabel).margin(16)
        }
    }
    
    override func bind(_ model: NotificationList) {
        notificationLabel.text = model.content
        notificationLabel.flex.markDirty()
    }
}
