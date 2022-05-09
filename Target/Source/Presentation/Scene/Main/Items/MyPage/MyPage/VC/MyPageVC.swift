
import UIKit
import RxDataSources
import RxSwift
import RxViewController
import PinLayout
import RxCocoa
import FlexLayout

final class MyPageVC: baseVC<MyPageReactor> {
    
    //MARK: - Properties
    
    private let headerContainer = UIView()
    
    private let mainContainer = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    
    private let postValueContainer = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    
    private let describeContainer = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    private let postContainer = UIView()
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
    }
    
    //MARK: - MenuAction
    private lazy var modifyProfile = UIAction(title: "프로필 수정",image: UIImage(systemName: "pencil"),handler: { [weak self] _ in
        self?.reactor?.action.onNext(.modifyButtonDidTap)
    })
    private lazy var setting = UIAction(title: "설정",image: UIImage(systemName: "gearshape.fill"), handler: { [weak self]_ in self?.reactor?.action.onNext(.settingButtonDidTap)})
    private lazy var cancel = UIAction(title: "취소", attributes: .destructive, handler: { _ in print("취소") })

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
    private let introduce = UITextView().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 13)
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.text = "나는 최형우"
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    private let webSite = UITextView().then{
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.textColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.text = "https://www.instagram.com/baegteun/"
        $0.dataDetectorTypes = .link
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
    
    private let sortButton = SortButton()
    
    private let postListTableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(PostCell.self, forCellReuseIdentifier: PostCell.reusableID)
        $0.rowHeight = 60
        $0.separatorStyle = .none
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
        $0.showsVerticalScrollIndicator = false
    }
    
    override func configureNavigation() {
        self.navigationItem.configLeftLogo()
        self.navigationItem.configBack()
        self.navigationItem.setRightBarButtonItems([ellipsis], animated: true)
    }
    
    override func setUp() {
        postListTableView.rx.setDelegate(self).disposed(by: disposeBag)
        view.backgroundColor = MOIZAAsset.moizaGray2.color
        if #available(iOS 14.0, *) {
            ellipsis.menu = UIMenu(identifier: nil, options: .displayInline, children: [modifyProfile,setting,cancel])
        } else {}
    }
    
    // MARK: - UI
    override func addView() {
            view.addSubViews(headerContainer,postContainer)
            headerContainer.addSubViews(mainView,descriptionView,backgroundView,sortButton,myPostLabel,profile)
            mainView.addSubViews(mainContainer,postValueContainer,profileName,postLabel,postValueLabel,followingButton,followerButton)
            descriptionView.addSubViews(describeContainer)
            describeContainer.addSubViews(introduce,webSite)
        }
        
        override func setLayoutSubViews() {
            headerContainer.pin.width(100%).height(402)
            backgroundView.pin.height(99).width(100%)
            profile.pin.horizontally(18).height(100).width(100).top(69)
            mainView.pin.below(of: backgroundView, aligned: .center).height(133).width(100%)
            mainContainer.pin.height(60).width(254).marginLeft(22).after(of: profile)
            postValueContainer.pin.height(60).width(32).topLeft(to: mainContainer.anchor.bottomLeft)
            followerButton.pin.height(60).width(60).after(of: postValueContainer, aligned: .center).marginLeft(10%)
            followingButton.pin.height(60).width(60).after(of: followerButton, aligned: .center).marginLeft(7%)
            descriptionView.pin.below(of: mainView, aligned: .left).marginTop(11).height(82).width(100%)
            describeContainer.pin.top(20).horizontally(14).height(35).width(315)
            myPostLabel.pin.below(of: descriptionView, aligned: .start).marginTop(40).height(16).width(68)
            sortButton.pin.below(of: descriptionView, aligned: .end).marginTop(34).height(28).width(63).sizeToFit()
            postContainer.pin.all(view.pin.safeArea)
            
            mainContainer.flex.define { flex in
                flex.addItem(profileName).marginVertical(8).marginTop(15)
                flex.addItem(schoolKind)
            }
            postValueContainer.flex.define { flex in
                flex.addItem(postLabel).marginTop(20).alignSelf(.center)
                flex.addItem(postValueLabel).marginVertical(8).alignSelf(.center)
            }
            
            followerButton.flex.define { flex in
                flex.addItem(followerLabel).marginTop(20).alignSelf(.center)
                flex.addItem(followerValueLabel).marginVertical(8).alignSelf(.center)
            }
            followingButton.flex.define { flex in
                flex.addItem(followingLabel).marginTop(20).alignSelf(.center)
                flex.addItem(followingValueLabel).marginVertical(8).alignSelf(.center)
            }
            describeContainer.flex.define { flex in
                flex.addItem(introduce)
                flex.addItem(webSite).marginVertical(8)
            }
            postContainer.flex.define { flex in
                flex.addItem(postListTableView).grow(1).bottom(0).marginHorizontal(16)
            }
            mainContainer.flex.layout()
            postValueContainer.flex.layout()
            followerButton.flex.layout()
            followingButton.flex.layout()
            describeContainer.flex.layout()
            postContainer.flex.layout()
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
        
        postListTableView.rx.didScroll
            .withLatestFrom(self.postListTableView.rx.contentOffset)
            .map { [weak self] in
                Reactor.Action.pagenation(
                    contentHeight: self?.postListTableView.contentSize.height ?? 0,
                    contentOffsetY: $0.y,
                    scrollViewHeight: self?.bound.height ?? 0
                )
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindAction(reactor: MyPageReactor) {
        self.rx.viewWillAppear.do(onNext: { _ in UserDefaultsLocal.shared.post = .normal } )
            .map { _ in Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: MyPageReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        let postDS = RxTableViewSectionedReloadDataSource<PostSection> { _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: PostCell.reusableID) as? PostCell else { return .init() }
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.postItems)
            .map { [PostSection.init(header: "", items: $0)] }
            .bind(to: postListTableView.rx.items(dataSource: postDS))
            .disposed(by: disposeBag)
    }
}
// MARK: - UITableViewDelegate
extension MyPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerContainer
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerContainer.frame.height
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerHeight: CGFloat = headerContainer.frame.height
        if scrollView.contentOffset.y <= headerHeight, scrollView.contentOffset.y >= 0 {
            scrollView.contentInset = .init(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
        } else if scrollView.contentOffset.y >= headerHeight {
            scrollView.contentInset = .init(top: -headerHeight, left: 0, bottom: 0, right: 0)
        }
    }
}
