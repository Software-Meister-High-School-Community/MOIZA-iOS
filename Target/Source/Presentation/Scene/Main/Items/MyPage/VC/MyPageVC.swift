
import UIKit
import Hero
import RxDataSources
import RxSwift
import RxViewController
import PinLayout
import FlexLayout

final class MyPageVC: baseVC<MyPageReactor> {
    
    private let mainContainer = UIView()
    
    private let ellipsis = UIButton().then{
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
    }
    
    private let backgroundView = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaPrimaryYellow.color
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 5
    }
    
    private let mainView = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaConstGray1.color
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 5
    }
    
    private let profile = UIImageView().then{
        $0.image = UIImage(systemName: "person.crop.circle.fill")
        $0.tintColor = MOIZAAsset.moizaGray4.color
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 150
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let profileName = UILabel().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 18)
        $0.text = "최형우"
    }
    
    private let schoolKind = UILabel().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 13)
        $0.text = "광소마 재학생"
    }
    
    private let postLabel = UILabel().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.text = "게시물"
    }
    private let postValueLabel = UILabel().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 12)
        $0.text = "0"
    }
    
    private let followerButton = UIButton().then{
        $0.backgroundColor = .none
    }
    private let followerLabel = UILabel().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.text = "팔로워"
    }
    private let followerValueLabel = UILabel().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 12)
        $0.text = "0"
    }
    
    private let followingButton = UIButton().then{
        $0.backgroundColor = .none
    }
    private let followingLabel = UILabel().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.text = "팔로잉"
    }
    private let followingValueLabel = UILabel().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 12)
        $0.text = "0"
    }
    
    override func configureNavigation() {
        self.navigationItem.configLeftLogo()
        self.navigationItem.ellipsis()
    }
}
