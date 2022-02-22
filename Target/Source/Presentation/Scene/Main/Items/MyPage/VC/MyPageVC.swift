
import UIKit
import Hero
import RxDataSources
import RxSwift
import RxViewController
import PinLayout
import FlexLayout

final class MyPageVC: baseVC<MyPageReactor> {
    
    //MARK: - Properties
    private let mainContainer = UIView()
    
    private let describeContainer = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
    }
    
    private let modifyProfile = UIAction(title: "프로필 수정",image: UIImage(systemName: "pencil"),handler: {_ in print("프로필 설정")})
    private let setting = UIAction(title: "설정",image: UIImage(systemName: "gearshape.fill"), handler: {_ in print("설정")})
    private let cancel = UIAction(title: "취소", attributes: .destructive, handler: { _ in print("취소") })

    private let ellipsis = UIBarButtonItem(image: .init(systemName: "ellipsis")?.downSample(size: .init(width: 12, height: 1)).tintColor(MOIZAAsset.moizaGray6.color), style: .plain, target: nil, action: nil)
    
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
    private let introduceLabel = UILabel().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 13)
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.text = "나는 최형우"
    }
    private let webSiteLabel = UILabel().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.textColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.text = "https://www.instagram.com/baekteun/"
    }
    private let profile = UIImageView().then{
        $0.image = UIImage(systemName: "person.crop.circle.fill")?.withRenderingMode(.alwaysOriginal)
        $0.tintColor = MOIZAAsset.moizaGray4.color
        $0.contentMode = .scaleAspectFill
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
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.text = "게시물"
    }
    private let postValueLabel = UILabel().then{
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 12)
        $0.text = "5123"
    }
    
    private let followerButton = UIButton().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    private let followerLabel = UILabel().then{
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.text = "팔로워"
    }
    private let followerValueLabel = UILabel().then{
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 12)
        $0.text = "80"
    }
    
    private let followingButton = UIButton().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    private let followingLabel = UILabel().then{
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.text = "팔로잉"
    }
    private let followingValueLabel = UILabel().then{
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.bold, size: 12)
        $0.text = "80"
    }
    
    private let myPostLabel = UILabel().then{
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.text = "나의 게시물"
    }
    
    private let sortButton = UIButton().then{
        $0.layer.borderWidth = 1
        $0.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        $0.layer.cornerRadius = 5
        $0.setImage(UIImage(named: "MOIZA_Funnel")?.withRenderingMode(.alwaysOriginal).tintColor(MOIZAAsset.moizaGray3.color), for: .normal)
        $0.setTitle("정렬", for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.setTitleColor(MOIZAAsset.moizaGray5.color, for: .normal)
        $0.contentHorizontalAlignment = .center
        $0.semanticContentAttribute = .forceLeftToRight
        $0.imageEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 41)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 12)
    }
    
    override func configureNavigation() {
        self.navigationItem.configLeftLogo()
        self.navigationItem.setRightBarButtonItems([ellipsis], animated: true)
    }
    
    override func setUp() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
        if #available(iOS 14.0, *) {
            ellipsis.menu = UIMenu(identifier: nil, options: .displayInline, children: [modifyProfile,setting,cancel])
        } else {}
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(scrollView)
        scrollView.addSubViews(backgroundView,descriptionView,mainView,profile,myPostLabel,sortButton)
        mainView.addSubViews(mainContainer,profileName,postLabel,postValueLabel,followingButton,followerButton)
        descriptionView.addSubViews(introduceLabel,webSiteLabel,describeContainer)
    }
    
    override func setLayoutSubViews() {
        scrollView.pin.all(view.pin.safeArea)
        scrollView.contentSize = .init(width: scrollView.bounds.width, height: scrollView.bounds.height*1.15)
        backgroundView.pin.horizontally(16).height(99).width(92%)
        profile.pin.horizontally(34).height(84).width(84).top(69)
        mainView.pin.below(of: backgroundView, aligned: .center).height(133).width(92%)
        mainContainer.pin.top(15).horizontally(124).height(115).width(234)
        descriptionView.pin.below(of: mainView, aligned: .center).marginTop(11).height(82).width(92%)
        describeContainer.pin.top(20).horizontally(14).height(36).width(315)
        myPostLabel.pin.below(of: descriptionView, aligned: .start).marginTop(40).height(16).width(68)
        sortButton.pin.below(of: descriptionView, aligned: .end).marginTop(34).height(28).width(63)
        
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
        
        describeContainer.flex.define { flex in
            flex.addItem(introduceLabel)
            flex.addItem(webSiteLabel).marginVertical(8)
        }
        mainContainer.flex.layout()
        describeContainer.flex.layout()
    }
    
    override func setLayout() {
        
    }
    override func bindView(reactor: MyPageReactor) {
        sortButton.rx.tap
            .map { Reactor.Action.sortButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        followerButton.rx.tap
            .map { Reactor.Action.followerButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        followingButton.rx.tap
            .map { Reactor.Action.followingButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
}
