import UIKit
import PinLayout
import FlexLayout

final class CommentCell: baseTableViewCell<Comment> {
    // MARK: - Metric
    enum Metric {
        static let marginHorizontal: CGFloat = 16
    }
    // MARK: - Properties
    private let rootContainer = UIView().then {
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = true
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    private let userInfoLabel = UILabel().then {
        $0.text = "TEST"
    }
    private let moreButton = UIButton().then {
        $0.setImage(.init(systemName: "ellipsis"), for: .normal)
    }
    private let contentLabel = UILabel().then {
        $0.text = "TEST"
    }
    private let childCommentsButton = UIButton().then {
        $0.setImage(.init(systemName: "bubble.right"), for: .normal)
    }
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(rootContainer)
    }
    override func setLayoutSubviews() {
        layout()
    }
    override func setLayout() {
        contentView.flex.marginVertical(12.5).define { flex in
            flex.addItem().direction(.row).marginHorizontal(Metric.marginHorizontal).define { flex in
                flex.addItem(profileImageView).size(36)
                flex.addItem(userInfoLabel).grow(1)
                flex.addItem(moreButton)
            }
            flex.addItem(contentLabel).marginTop(20).marginHorizontal(Metric.marginHorizontal)
            flex.addItem(childCommentsButton).marginTop(20)
        }
    }
    override func configureCell() {
        contentView.backgroundColor = MOIZAAsset.moizaGray1.color
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
    }
    override func bind(_ model: Comment) {
        contentView.flex.markDirty()
        setNeedsLayout()
    }
    private func layout() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return contentView.frame.size
    }
}
