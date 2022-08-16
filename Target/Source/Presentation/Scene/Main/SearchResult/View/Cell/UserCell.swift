import UIKit
import PinLayout
import FlexLayout
import Kingfisher
import Then

final class UserCell: baseCollectionViewCell<SearchUserList> {
    // MARK: - Metric
    enum Metric {
        
    }
    enum Font {
        static let userScopeFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 8)
        static let nameFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
        static let schoolFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 10)
    }
    enum Color {
        static let userScopeTextColor = MOIZAAsset.moizaGray5.color
        static let nameTextColor = MOIZAAsset.moizaGray6.color
        static let schoolTextColor = MOIZAAsset.moizaGray6.color
    }
    
    // MARK: - Properties
    private let rootContainer = UIView()
    private let userProfileImageView = UIImageView().then {
        $0.layer.cornerRadius = 26.5
        $0.clipsToBounds = true
    }
    private let userScopeLabel = UILabel().then {
        $0.font = Font.userScopeFont
        $0.textColor = Color.userScopeTextColor
    }
    private let usernameLabel = UILabel().then {
        $0.font = Font.nameFont
        $0.textColor = Color.nameTextColor
    }
    private let schoolLabel = UILabel().then {
        $0.font = Font.schoolFont
        $0.textColor = Color.schoolTextColor
        $0.lineBreakMode = .byTruncatingMiddle
    }
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(rootContainer)
    }
    override func setLayoutSubviews() {
        rootContainer.pin.all()
        
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.alignItems(.center).define { flex in
            flex.addItem(userProfileImageView).size(53).marginTop(14)
            flex.addItem(userScopeLabel).marginTop(14)
            flex.addItem(usernameLabel).marginTop(6)
            flex.addItem(schoolLabel).marginTop(6).marginHorizontal(14)
        }
    }
    override func configureCell() {
        backgroundColor = MOIZAAsset.moizaGray1.color
        layer.cornerRadius = 11
    }
    
    override func bind(_ model: SearchUserList) {
        userProfileImageView.kf.setImage(with: URL(string: model.profileImageUrl))
        userScopeLabel.text = model.userType.display
        usernameLabel.text = model.name
        schoolLabel.text = model.school.display
    }
}
