
import UIKit
import Then
import FlexLayout
import RxSwift
import Kingfisher

final class FollowerCell: baseTableViewCell<FollowerUserList> {
    
    private let view = UIView().then {
        $0.backgroundColor = .clear
    }
    private let userProfileImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 30
    }
    
    private let userIdLabel = UILabel().then{
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
    }
    private let schoolLabel = UILabel().then {
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.lineBreakMode = .byTruncatingMiddle
    }
    
    private let isFollowButton = UIButton().then {
        $0.setTitle("맞팔로우", for: .normal)
        $0.backgroundColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.layer.cornerRadius = 5
        $0.setTitleColor(MOIZAAsset.moizaGray1.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 10)
    }
    private let deleteButton = UIButton().then {
        $0.setTitle("삭제", for: .normal)
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        $0.layer.borderWidth = 0.5
        $0.setTitleColor(MOIZAAsset.moizaGray4.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 10)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
        userProfileImageView.image = nil
        schoolLabel.text = nil
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
        view.flex.direction(.row).marginVertical(10).alignItems(.center).define { flex in
            flex.addItem(userProfileImageView).marginLeft(4).size(55)
            
            flex.addItem().direction(.row).grow(1).define { flex in
                flex.addItem().marginLeft(16).maxWidth(40%).define { flex in
                    flex.addItem(userIdLabel)
                    flex.addItem(schoolLabel).marginTop(4)
                }
                flex.addItem().direction(.rowReverse).grow(1).define { flex in
                    flex.addItem(deleteButton).width(50).height(27)
                    flex.addItem(isFollowButton).width(50).height(27).marginRight(10)
                }
            }
        }
    }
    override func bind(_ model: FollowerUserList) {
        userProfileImageView.kf.setImage(with: URL(string: model.profileImageUrl) ?? .none,
                                     placeholder: UIImage(),
                                     options: [])
        userProfileImageView.backgroundColor = MOIZAAsset.moizaGray3.color
    
        userIdLabel.text = model.name
        schoolLabel.text = "\(model.school.display) \(model.userScope.display)"
        isFollowButton.isHidden = model.isFollow
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

