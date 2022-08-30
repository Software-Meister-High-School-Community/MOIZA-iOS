//
//  ModifyProfile.swift
//  MOIZA
//
//  Created by 임준화 on 2022/06/26.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxViewController
import PinLayout
import RxCocoa
import FlexLayout

final class ModifyProfileVC: BaseVC<ModifyProfileReactor> {
    
    private let headerContainer = UIView()
    
    private let mainContainer = UIView().then{
        $0.backgroundColor = .clear
    }
    
    private let postValueContainer = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
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
    
    private let changeProfileButton = UIButton().then{
        $0.setTitle("사진 바꾸기", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray5.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        $0.layer.borderWidth = 1
        $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
    }
    
    private let changeBackgroundColorLabel = UILabel().then{
        $0.textColor = MOIZAAsset.moizaGray5.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.text = "배경 컬러 변경"
    }
    override func configureNavigation() {
        self.navigationItem.configLeftLogo()
    }
    
    override func setUp() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    
    // MARK: - UI
    override func addView() {
            view.addSubViews(headerContainer)
            headerContainer.addSubViews(mainView,backgroundView,profile,changeBackgroundColorLabel,changeProfileButton)
            mainView.addSubViews(mainContainer,postValueContainer,profileName,postLabel,postValueLabel,followingButton,followerButton)
        }
        
        override func setLayoutSubViews() {
            headerContainer.pin.all(view.pin.safeArea)
            backgroundView.pin.height(99).width(92%).hCenter()
            profile.pin.horizontally(18).height(100).width(100).top(69)
            changeProfileButton.pin.below(of: profile, aligned: .center).marginTop(16).height(30).width(80).sizeToFit()
            mainView.pin.below(of: backgroundView, aligned: .center).height(133).width(92%)
            mainContainer.pin.height(60).width(254).marginLeft(22).after(of: profile)
            postValueContainer.pin.height(60).width(32).topLeft(to: mainContainer.anchor.bottomLeft)
            followerButton.pin.height(60).width(60).after(of: postValueContainer, aligned: .center).marginLeft(10%)
            followingButton.pin.height(60).width(60).after(of: followerButton, aligned: .center).marginLeft(7%)
            changeBackgroundColorLabel.pin.below(of: mainView, aligned: .start).marginTop(40).height(16).width(82)
    
            
            
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
            mainContainer.flex.layout()
            postValueContainer.flex.layout()
            followerButton.flex.layout()
            followingButton.flex.layout()
        }
        
        override func setLayout() {
            
        }
    override func bindView(reactor: ModifyProfileReactor) {
        
        followerButton.rx.tap
            .map { Reactor.Action.followerButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        followingButton.rx.tap
            .map { Reactor.Action.followingButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    override func bindAction(reactor: ModifyProfileReactor) {
        
    }
    override func bindState(reactor: ModifyProfileReactor) {
        
    }
}
// MARK: - UITableViewDelegate
extension ModifyProfileVC: UITableViewDelegate {
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
