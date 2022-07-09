import UIKit
import Then
import FlexLayout
import RxSwift

final class PostCell: baseTableViewCell<PostList> {
    // MARK: - Properties
    private let view = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel().then {
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
    }
    private let commentCount = UIButton().then {
        $0.setImage(.init(systemName: "bubble.right")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray5.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
    }
    private let likeCount = UIButton().then {
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
        commentCount.setTitle("", for: .normal)
        likeCount.setTitle("", for: .normal)
        commentCount.imageView?.image = nil
        likeCount.imageView?.image = nil
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
                flex.addItem().shrink(1).grow(1).alignItems(.start).define { flex in
                    flex.addItem(commentCount)
                }
                flex.addItem().shrink(1).grow(1).alignItems(.start).define { flex in
                    flex.addItem(likeCount)
                }
            }
        }
    }
    override func bind(_ model: PostList) {
        iconImageView.image = model.type == .question ?
        .init(systemName: "questionmark.circle.fill")?.tintColor(MOIZAAsset.moizaPrimaryYellow.color) :
        MOIZAAsset.moizaBookReader.image.tintColor(MOIZAAsset.moizaPrimaryYellow.color)
        titleLabel.text = model.title
        commentCount.setTitle("\(model.commentCount)", for: .normal)
        likeCount.setTitle("\(model.likeCount)", for: .normal)
        if model.isLike {
            likeCount.setImage(.init(systemName: "heart.fill")?.tintColor(MOIZAAsset.moizaPrimaryYellow.color), for: .normal)
        } else {
            likeCount.setImage(.init(systemName: "heart")?.tintColor(MOIZAAsset.moizaGray4.color), for: .normal)
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
