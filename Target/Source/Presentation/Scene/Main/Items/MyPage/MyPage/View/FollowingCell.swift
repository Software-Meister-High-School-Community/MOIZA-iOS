
import UIKit
import Then
import FlexLayout
import RxSwift
import Kingfisher

final class FollowingCell: baseTableViewCell<UserList> {
    
    private let view = UIView().then {
        $0.backgroundColor = .clear
    }
    private let userProfileImageView = UIImageView().then{
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 30
    }
    
    private let userId = UILabel().then{
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
    }
    private let schoolLabel = UILabel().then {
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
    }
    
    private let isFollowingButton = UIButton().then {
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        $0.layer.borderWidth = 0.5
        $0.setTitleColor(MOIZAAsset.moizaGray5.color, for: .normal)
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
        isFollowingButton.setTitle("팔로잉", for: .normal)
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
            flex.addItem(userProfileImageView).marginLeft(4).size(60)
            
            flex.addItem().direction(.column).marginLeft(16).grow(1).define { flex in
                flex.addItem(userId).width(45)
                flex.addItem(schoolLabel).width(100%).marginTop(4)
            }
            
            flex.addItem().direction(.row).paddingLeft(15).grow(1).define { flex in
                flex.addItem().shrink(1).grow(1).alignItems(.end).define { flex in
                    flex.addItem(isFollowingButton).width(50).height(27)
                }
            }
        }
    }
    override func bind(_ model: UserList) {
        userProfileImageView.kf.setImage(with: URL(string: model.profileImageURL) ?? .none,
                                     placeholder: UIImage(),
                                     options: [])
        userProfileImageView.backgroundColor = MOIZAAsset.moizaGray3.color
    
        userId.text = model.name
        schoolLabel.text = model.school.display
        isFollowingButton.setTitle("팔로잉", for: .normal)
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

