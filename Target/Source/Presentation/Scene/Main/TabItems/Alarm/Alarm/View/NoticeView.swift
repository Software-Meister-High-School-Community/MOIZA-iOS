import PinLayout
import FlexLayout
import UIKit
import Then

final class NoticeView: UIView {
    // MARK: - Properties
    private let contentLabel = UILabel().then {
        $0.text = "고정된 공지가 없습니다."
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 14)
        $0.textColor = MOIZAAsset.moizaGray5.color
        $0.textAlignment = .left
    }
    
    init() {
        super.init(frame: .zero)
        setLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setNotice(notice: NoticeList?) {
        contentLabel.text = notice?.title ?? "고정된 공지가 없습니다."
    }
    
    private func setLayout() {
        self.flex.define { flex in
            flex.addItem(contentLabel).grow(1).marginHorizontal(16)
        }
    }
    private func configureView() {
        self.backgroundColor = MOIZAAsset.moizaGray1.color
        self.layer.cornerRadius = 5
    }
}
