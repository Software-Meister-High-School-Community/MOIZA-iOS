import UIKit
import FlexLayout

final class RecommendCell: baseCollectionViewCell<PostList> {
    // MARK: - Properties
    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private let typeLabel = UILabel().then {
        $0.textColor = MOIZAAsset.moizaConstGray1.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 20)
    }
    private let titleLabel = UILabel().then {
        $0.textColor = MOIZAAsset.moizaConstGray1.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.numberOfLines = 0
    }
    
    // MARK: - UI
    override func setLayoutSubviews() {
        contentView.flex.layout()
    }
    override func setLayout() {
        contentView.flex.padding(20).define { flex in
            flex.addItem(iconImageView).size(30).shrink(2)
            flex.addItem(typeLabel).shrink(1).paddingTop(10)
            flex.addItem(titleLabel).shrink(1).paddingTop(10)
        }
    }
    override func configureCell() {
        self.layer.cornerRadius = 20
    }
    
    override func bind(_ model: PostList) {
        iconImageView.image = model.type == .question ? MOIZAAsset.moizaQuestion.image : MOIZAAsset.moizaIdea.image
        typeLabel.text = model.type == .question ? "오늘의 질문" : "오늘의 꿀팁"
        titleLabel.text = model.title
    }
}
