import UIKit
import Then
import FlexLayout
import RxSwift

final class PostCell: BaseTableViewCell<PostList> {
    // MARK: - Properties
    private let view = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel().then {
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
    }
    private let commentCountButton = UIButton().then {
        $0.setImage(.init(systemName: "bubble.right")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray5.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
    }
    private let likeCountButton = UIButton().then {
        $0.setTitleColor(MOIZAAsset.moizaGray5.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
        iconImageView.image = nil
        titleLabel.text = nil
        commentCountButton.setTitle("", for: .normal)
        likeCountButton.setTitle("", for: .normal)
        commentCountButton.imageView?.image = nil
        likeCountButton.imageView?.image = nil
    }
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(view)
    }
    override func setLayoutSubviews() {
        view.pin.all()
        view.flex.layout()
    }
    override func setLayout() {
        view.flex.direction(.row).marginVertical(5).alignItems(.center).define { flex in
            flex.addItem(iconImageView).marginLeft(10).size(25)
            flex.addItem(titleLabel).width(52.4%).marginLeft(12)
            flex.addItem().direction(.row).paddingLeft(15).grow(1).define { flex in
                flex.addItem().shrink(1).grow(1).define { flex in
                    flex.addItem(commentCountButton)
                }
                flex.addItem().shrink(1).grow(1).define { flex in
                    flex.addItem(likeCountButton)
                }
            }
        }
    }
    override func bind(_ model: PostList) {
        iconImageView.image = model.type == .question ?
        .init(systemName: "questionmark.circle.fill")?.tintColor(MOIZAAsset.moizaPrimaryYellow.color) :
        MOIZAAsset.moizaBookReader.image.tintColor(MOIZAAsset.moizaPrimaryYellow.color)
        titleLabel.text = model.title
        commentCountButton.setTitle("\(model.commentCount)", for: .normal)
        commentCountButton.flex.markDirty()
        likeCountButton.setTitle("\(model.likeCount)", for: .normal)
        likeCountButton.flex.markDirty()
        if model.isLike {
            likeCountButton.setImage(.init(systemName: "heart.fill")?.tintColor(MOIZAAsset.moizaPrimaryYellow.color), for: .normal)
        } else {
            likeCountButton.setImage(.init(systemName: "heart")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
        }
    }
    override func configureCell() {
        self.backgroundColor = .clear
        self.view.backgroundColor = MOIZAAsset.moizaGray1.color
        view.layer.cornerRadius = 5
        self.selectionStyle = .none
    }
    override func darkConfigure() {
        self.view.backgroundColor = MOIZAAsset.moizaDark2.color
    }
}
