import UIKit
import PinLayout
import FlexLayout
import Kingfisher

final class CommentCell: baseTableViewCell<Comment> {
    // MARK: - Metric
    enum Metric {
        static let marginHorizontal: CGFloat = 16
        static let marginVertical: CGFloat = 16
    }
    // MARK: - Properties
    private let rootContainer = UIView().then {
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    private let authorLabel = PaddingLabel(padding: .init(top: 6, left: 6, bottom: 6, right: 6)).then {
        $0.textColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.text = "작성자"
        $0.layer.borderWidth = 1
        $0.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        $0.layer.cornerRadius = 5
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.textAlignment = .center
    }
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = true
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    private let userInfoLabel = UILabel().then {
        $0.text = "TEST"
        $0.textColor = MOIZAAsset.moizaConstGray5.color
        $0.lineBreakMode = .byTruncatingMiddle
    }
    private let moreButton = UIButton().then {
        $0.setImage(.init(systemName: "ellipsis"), for: .normal)
    }
    private let contentLabel = UILabel().then {
        $0.text = "TEST"
        $0.numberOfLines = 0
    }
    private let childCommentsButton = UIButton().then {
        $0.setImage(.init(systemName: "bubble.right")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray4.color, for: .normal)
    }
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(rootContainer)
    }
    override func setLayoutSubviews() {
        super.setLayoutSubviews()
        rootContainer.pin.all()
        layout()
    }
    override func setLayout() {
        rootContainer.flex.marginVertical(12.5).define { flex in
            flex.addItem(authorLabel).marginTop(Metric.marginVertical).marginLeft(Metric.marginHorizontal).width(46).height(26).display(.none)
            flex.addItem().direction(.row).marginTop(Metric.marginVertical).paddingHorizontal(Metric.marginHorizontal).define { flex in
                flex.addItem(profileImageView).size(36).shrink(1)
                flex.addItem(userInfoLabel).marginHorizontal(10).grow(1).shrink(5)
                flex.addItem(moreButton).size(27).shrink(1)
            }
            flex.addItem(contentLabel).marginTop(20).marginHorizontal(Metric.marginHorizontal).grow(1)
            flex.addItem(childCommentsButton).alignSelf(.start).marginLeft(Metric.marginHorizontal).marginVertical(Metric.marginVertical)
        }
    }
    override func configureCell() {
        rootContainer.backgroundColor = MOIZAAsset.moizaGray1.color
        rootContainer.layer.cornerRadius = 20
        rootContainer.clipsToBounds = true
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    override func darkConfigure() {
        rootContainer.backgroundColor = MOIZAAsset.moizaDark2.color
    }
    override func bind(_ model: Comment) {
        profileImageView.kf.setImage(with: URL(string: model.author.profileImageUrl) ?? .none,
                                     placeholder: UIImage(),
                                     options: [])
        let str = NSMutableAttributedString(string: "\(model.author.name) • \(model.author.schoolName.display) • \(model.author.type.display)")
            .setColorForText(textToFind: model.author.name, withColor: MOIZAAsset.moizaGray6.color)
        userInfoLabel.attributedText = str
        userInfoLabel.flex.markDirty()
        
        contentLabel.text = model.content
        contentLabel.flex.markDirty()
        
        childCommentsButton.setTitle("\(model.childComments?.count ?? 0)", for: .normal)
        childCommentsButton.flex.markDirty()
        
        rootContainer.flex.layout(mode: .adjustHeight)
    }
    private func layout() {
        rootContainer.flex.layout(mode: .adjustHeight)
        contentView.flex.layout(mode: .adjustHeight)
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        rootContainer.pin.width(size.width)
        layout()
        return contentView.frame.size
    }
}
