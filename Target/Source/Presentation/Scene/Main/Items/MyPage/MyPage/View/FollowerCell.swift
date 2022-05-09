
import UIKit
import Then
import FlexLayout
import RxSwift
import Kingfisher

final class FollowerCell: baseTableViewCell<UserList> {
    
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
    }
    
    private let isFollowButton = UIButton().then {
        $0.backgroundColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.layer.cornerRadius = 5
        $0.setTitleColor(MOIZAAsset.moizaGray1.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 10)
    }
    private let deleteButton = UIButton().then {
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
        isFollowButton.setTitle("맞팔로우", for: .normal)
        deleteButton.setTitle("삭제", for: .normal)
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
                flex.addItem(userIdLabel).width(45)
                flex.addItem(schoolLabel).width(100%).marginTop(4)
            }
            
            flex.addItem().direction(.row).paddingLeft(10).grow(1).define { flex in
                flex.addItem().shrink(1).grow(1).alignItems(.center).define { flex in
                    flex.addItem(isFollowButton).width(50).height(27).marginRight(10)
                }
                flex.addItem().shrink(1).grow(1).alignItems(.end).define { flex in
                    flex.addItem(deleteButton).width(50).height(27).marginRight(5)
                }
            }
        }
    }
    override func bind(_ model: UserList) {
        userProfileImageView.kf.setImage(with: URL(string: model.profileImageUrl) ?? .none,
                                     placeholder: UIImage(),
                                     options: [])
        userProfileImageView.backgroundColor = MOIZAAsset.moizaGray3.color
    
        userIdLabel.text = model.name
        schoolLabel.text = model.school.display
        isFollowButton.setTitle("맞팔로우", for: .normal)
        deleteButton.setTitle("삭제", for: .normal)
        if model.isFollow {
            isFollowButton.layer.isHidden = false
        } else {
            isFollowButton.layer.isHidden = true
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

