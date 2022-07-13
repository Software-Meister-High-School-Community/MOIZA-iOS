import UIKit
import PinLayout
import FlexLayout
import Kingfisher
import BTImageView
import Then

final class CommentCell: baseTableViewCell<Comment> {
    // MARK: - Metric
    enum Metric {
        static let marginHorizontal: CGFloat = 16
        static let marginVertical: CGFloat = 16
    }
    enum Font {
        static let authorFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        static let userInfoFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        static let dateFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 10)
        static let contentFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        static let childCommentFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
    }
    enum Color {
        static let authorTextColor = MOIZAAsset.moizaPrimaryBlue.color
        static let userInfoTextColor = MOIZAAsset.moizaGray5.color
        static let dateTextColor = MOIZAAsset.moizaGray4.color
        static let contentTextColor = MOIZAAsset.moizaGray6.color
        static let childCommentColor = MOIZAAsset.moizaGray4.color
    }
    
    // MARK: - Properties
    private let rootContainer = UIView().then {
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    private let authorLabel = PaddingLabel(padding: .init(top: 6, left: 6, bottom: 6, right: 6)).then {
        $0.textColor = Color.authorTextColor
        $0.font = Font.authorFont
        $0.text = "작성자"
        $0.layer.borderWidth = 1
        $0.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        $0.layer.cornerRadius = 5
        $0.textAlignment = .center
    }
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = true
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    private let userInfoLabel = UILabel().then {
        $0.font = Font.userInfoFont
        $0.textColor = Color.userInfoTextColor
        $0.lineBreakMode = .byTruncatingMiddle
    }
    private let dateLabel = UILabel().then {
        $0.font = Font.dateFont
        $0.textColor = Color.dateTextColor
    }
    private let moreButton = UIButton().then {
        $0.setImage(.init(systemName: "ellipsis")?.tintColor(MOIZAAsset.moizaGray6.color), for: .normal)
    }
    private let contentLabel = UILabel().then {
        $0.font = Font.contentFont
        $0.textColor = Color.contentTextColor
        $0.numberOfLines = 0
    }
    private let commentImagesView = BTImageView().then {
        $0.aligns = [2, 2]
        $0.axis = .vertical
    }
    private let childCommentsButton = UIButton().then {
        $0.setImage(.init(systemName: "bubble.right")?.tintColor(Color.childCommentColor), for: .normal)
        $0.setTitleColor(Color.childCommentColor, for: .normal)
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
                flex.addItem().marginHorizontal(10).grow(1).shrink(5).define { flex in
                    flex.addItem(userInfoLabel)
                    flex.addItem(dateLabel)
                }
                flex.addItem(moreButton).size(27).shrink(1)
            }
            flex.addItem(contentLabel).marginTop(20).marginHorizontal(Metric.marginHorizontal).grow(1)
            flex.addItem(commentImagesView).marginTop(20).marginHorizontal(Metric.marginHorizontal).width(bound.width-32).height((bound.width-32) * 0.5743).display(.none)
            flex.addItem(childCommentsButton).marginLeft(Metric.marginHorizontal).marginVertical(Metric.marginVertical).alignSelf(.start)
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
        
        dateLabel.text = "\(model.createdAt.year).\(model.createdAt.month).\(model.createdAt.day)"
        dateLabel.flex.markDirty()
        
        contentLabel.text = model.content
        contentLabel.flex.markDirty()
        
        childCommentsButton.setTitle("\(model.childComments?.count ?? 0)", for: .normal)
        childCommentsButton.flex.markDirty()
        
        if let urls = model.imageUrls, !urls.isEmpty {
            commentImagesView.setImages(urls: urls)
            commentImagesView.flex.display(.flex)
        } else {
            commentImagesView.flex.display(.none)
        }
        
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
