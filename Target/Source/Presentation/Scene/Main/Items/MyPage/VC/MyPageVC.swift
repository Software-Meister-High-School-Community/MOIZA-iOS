
import UIKit
import Hero
import RxDataSources
import RxSwift
import RxViewController
import PinLayout
import FlexLayout

final class MyPageVC: baseVC<MyPageReactor> {
    
    //MARK: - Properties
    private let mainContainer = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
    }
    
    private let ellipsis = UIButton().then{
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
    }
    
    private let backgroundView = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaPrimaryYellow.color
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 5
    }
    
    private let mainView = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.layer.cornerRadius = 5
    }
    private let descriptionView = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.layer.cornerRadius = 5
    }
    private let profile = UIImageView().then{
        $0.image = UIImage(systemName: "person.crop.circle.fill")
        $0.tintColor = MOIZAAsset.moizaGray4.color
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 150
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    private let profileName = UILabel().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 18)
        $0.text = "최형우"
    }
    
    private let schoolKind = UILabel().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 13)
        $0.text = "광주소프트웨어마이스터고 재학생"
    }
    
    private let postLabel = UILabel().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.text = "게시물"
    }
    private let postValueLabel = UILabel().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 12)
        $0.text = "512"
    }
    
    private let followerButton = UIButton().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
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
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
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
    
    override func setUp() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(scrollView)
        scrollView.addSubViews(backgroundView,descriptionView,mainView,profile)
        mainView.addSubViews(mainContainer,profileName,postLabel,postValueLabel)
    }
    
    override func setLayoutSubViews() {
        scrollView.pin.all(view.pin.safeArea)
        scrollView.contentSize = .init(width: scrollView.bounds.width, height: scrollView.bounds.height*1.15)
        backgroundView.pin.horizontally(16).height(99).width(92%)
        profile.pin.horizontally(34).height(84).width(84).top(69)
        mainView.pin.below(of: backgroundView, aligned: .center).horizontally(16).height(133).width(92%)
        mainContainer.pin.top(15).horizontally(124).height(115).width(234)
        
        mainContainer.flex.define { flex in
            flex.addItem(profileName)
            flex.addItem(schoolKind).marginVertical(8)
            flex.addItem().direction(.row).define { flex in
                flex.addItem().marginBottom(20).alignSelf(.start).define { flex in
                    flex.addItem(postLabel).marginVertical(6).direction(.column)
                    flex.addItem(postValueLabel).alignSelf(.center)
                }
                flex.addItem().marginHorizontal(48).alignSelf(.center).bottom(7).define { flex in
                    flex.addItem(followerButton).justifyContent(.center).width(50).height(55).define { flex in
                        flex.addItem(followerLabel).alignSelf(.center).marginVertical(6)
                        flex.addItem(followerValueLabel).alignSelf(.center).marginBottom(5)
                    }
                }
                flex.addItem().alignSelf(.end).bottom(10).define { flex in
                    flex.addItem(followingButton).justifyContent(.center).width(50).height(55).define { flex in
                        flex.addItem(followingLabel).alignSelf(.center).marginVertical(6)
                        flex.addItem(followingValueLabel).alignSelf(.center).marginBottom(5)
                    }
                }
            }
        }
        mainContainer.flex.layout()
    }
    
    override func setLayout() {
    }
}
