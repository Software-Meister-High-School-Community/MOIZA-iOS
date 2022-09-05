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
import Photos

final class ModifyProfileVC: BaseVC<ModifyProfileReactor> {
    
    private let scrollView = UIScrollView().then{
        $0.showsVerticalScrollIndicator = false
    }
    
    private let mainContainer = UIView().then{
        $0.backgroundColor = .clear
    }
    
    private let postValueContainer = UIView().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
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
    private let profileImageView = UIImageView().then{
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
        $0.setTitleColor(MOIZAAsset.moizaGray6.color, for: .normal)
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
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 38, height: 38)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        $0.showsHorizontalScrollIndicator = false
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        $0.collectionViewLayout = layout
        $0.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 12, left: 19, bottom: 12, right: 19)
        $0.backgroundColor = .clear
    }
    
    private let colorArray = [
        UIColor(red: 0.575, green: 0.174, blue: 0.086, alpha: 1),
        UIColor(red: 0.808, green: 0.294, blue: 0.224, alpha: 1),
        UIColor(red: 0.922, green: 0.392, blue: 0.224, alpha: 1),
        UIColor(red: 0.945, green: 0.741, blue: 0.416, alpha: 1),
        UIColor(red: 1, green: 0.71, blue: 0, alpha: 1),
        UIColor(red: 1, green: 0.847, blue: 0.046, alpha: 1),
        UIColor(red: 1, green: 0.882, blue: 0.6, alpha: 1),
        UIColor(red: 0.043, green: 0.354, blue: 0.055, alpha: 1),
        UIColor(red: 0.448, green: 0.562, blue: 0.377, alpha: 1),
        UIColor(red: 0.559, green: 0.854, blue: 0.263, alpha: 1),
        UIColor(red: 0.6, green: 0.714, blue: 1, alpha: 1),
        UIColor(red: 0, green: 0.282, blue: 1, alpha: 1),
        UIColor(red: 0.678, green: 0.631, blue: 0.965, alpha: 1),
        UIColor(red: 0.314, green: 0.169, blue: 0.545, alpha: 1),
        UIColor(red: 0.6, green: 0.88, blue: 1, alpha: 1),
        UIColor(red: 0.949, green: 0.725, blue: 0.839, alpha: 1),
        UIColor(red: 0.882, green: 0.765, blue: 0.737, alpha: 1),
        UIColor(red: 0.879, green: 0.879, blue: 0.879, alpha: 1),
        UIColor(red: 0.706, green: 0.706, blue: 0.706, alpha: 1),
        UIColor(red: 0.373, green: 0.373, blue: 0.373, alpha: 1),
        UIColor(red: 0.229, green: 0.228, blue: 0.228, alpha: 1)
    ]
    
    private let introduceLabel = UILabel().then{
        $0.textColor = MOIZAAsset.moizaGray5.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.text = "소개"
    }
    
    private let introduceButton = UIButton().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.layer.cornerRadius = 10
    }
    
    private let websiteLabel = UILabel().then{
        $0.textColor = MOIZAAsset.moizaGray5.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.text = "웹사이트 (최대 3개)"
    }
    
    private let websiteContainer = UIView().then{
        $0.backgroundColor = .clear
    }
    
    private let firstAddButton = WebsiteAddButton()
    private let secondAddButton = WebsiteAddButton()
    private let thirdAddButton = WebsiteAddButton()
    
    private let imagePicker = UIImagePickerController().then{
        $0.allowsEditing = true
    }
    
    override func configureNavigation() {
        self.navigationItem.configLeftLogo()
        self.navigationItem.configBack()
    }
    
    override func setUp() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
        collectionView.dataSource = self
        collectionView.delegate = self
        imagePicker.delegate = self
    }
    
    // MARK: - UI
    override func addView() {
            view.addSubViews(scrollView)
        scrollView.addSubViews(mainView,backgroundView,profileImageView,changeBackgroundColorLabel,changeProfileButton,collectionView,introduceLabel,introduceButton,websiteLabel,websiteContainer)
            mainView.addSubViews(mainContainer,postValueContainer,profileName,postLabel,postValueLabel,followingButton,followerButton)
        }
        
        override func setLayoutSubViews() {
            scrollView.pin.all()
            scrollView.contentSize = .init(width: bound.width, height: bound.height*1.05)
            backgroundView.pin.height(99).width(92%).hCenter()
            profileImageView.pin.horizontally(18).height(100).width(100).top(69)
            changeProfileButton.pin.below(of: profileImageView, aligned: .center).marginTop(16).height(30).width(80).sizeToFit()
            mainView.pin.below(of: backgroundView, aligned: .center).height(133).width(92%)
            mainContainer.pin.height(60).width(254).marginLeft(22).after(of: profileImageView)
            postValueContainer.pin.height(60).width(32).topLeft(to: mainContainer.anchor.bottomLeft)
            followerButton.pin.height(60).width(60).after(of: postValueContainer, aligned: .center).marginLeft(10%)
            followingButton.pin.height(60).width(60).after(of: followerButton, aligned: .center).marginLeft(7%)
            changeBackgroundColorLabel.pin.below(of: mainView, aligned: .start).marginTop(40).height(16).width(82)
            collectionView.pin.height(150).width(92%).below(of: changeBackgroundColorLabel, aligned: .start).marginTop(10)
            introduceLabel.pin.below(of: collectionView, aligned: .start).marginTop(15).height(16).width(26)
            introduceButton.pin.below(of: introduceLabel, aligned: .start).marginTop(10).width(of: collectionView).height(38)
            websiteLabel.pin.below(of: introduceButton, aligned: .start).marginTop(30).height(16).width(111)
            websiteContainer.pin.height(150).width(92%).below(of: websiteLabel, aligned: .start).marginTop(10)
            
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
            
            websiteContainer.flex.define { flex in
                flex.addItem(firstAddButton).width(100%).alignSelf(.center)
                flex.addItem(secondAddButton).width(100%).alignSelf(.center).marginTop(6)
                flex.addItem(thirdAddButton).width(100%).alignSelf(.center).marginTop(6)
            }
        
            mainContainer.flex.layout()
            postValueContainer.flex.layout()
            followerButton.flex.layout()
            followingButton.flex.layout()
            websiteContainer.flex.layout()
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
        
        changeProfileButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.photoAndCameraAction()
            })
            .disposed(by: disposeBag)
        
        introduceButton.rx.tap
            .map{ Reactor.Action.introduceButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        firstAddButton.rx.tap
            .map { Reactor.Action.websiteButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
            
        secondAddButton.rx.tap
            .map { Reactor.Action.websiteButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        thirdAddButton.rx.tap
            .map { Reactor.Action.websiteButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: ModifyProfileReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map{ $0.selectedData != nil }
            .withUnretained(self)
            .subscribe(onNext: { owner, isExist in
                owner.mainContainer.flex.layout()
            })
            .disposed(by: disposeBag)
    }
    
}

extension ModifyProfileVC: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colorArray[indexPath.row]
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

private extension ModifyProfileVC{
    func photoAndCameraAction(){
        reactor?.action.onNext(.alert(title: "업로드 방식을 선택해주세요.", message: "앨범에서 선택 또는 카메라로 촬영", style: .actionSheet, actions: [
            .init(title: "앨범", style: .default, handler: { [weak self] _ in
                self?.presentToPhotoAlbum()
            }),
            .init(title: "촬영", style: .default, handler: { [weak self] _ in
                self?.presentToCamera()
            }),
            .init(title: "취소", style: .cancel, handler: nil)
        ]))
    }
    func presentToPhotoAlbum() {
        self.imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    func presentToCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            self.reactor?.action.onNext(.errorAlert(title: "권한이 없습니다.", message: "카메라를 실행할 수 없습니다!"))
            return
        }
        self.imagePicker.sourceType = .camera
        self.imagePicker.mediaTypes = ["public.movie", "public.image"]
        self.imagePicker.cameraFlashMode = .auto
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ModifyProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var filename = ""
        if let asset = info[.phAsset] as? PHAsset, let fileName = asset.value(forKey: "filename") as? String {
            filename = fileName
        } else if let url = info[.imageURL] as? URL {
            filename = url.lastPathComponent
        } else if let url = info[.mediaURL] as? URL {
            filename = url.lastPathComponent
        }
        
        if let image = info[.editedImage] as? UIImage {
            reactor?.action.onNext(.imageDidSelected(image.jpegData(compressionQuality: 0.9), filename))
        } else if let image = info[.originalImage] as? UIImage {
            reactor?.action.onNext(.imageDidSelected(image.jpegData(compressionQuality: 0.9), filename))
        } else if let media = info[.mediaURL] as? URL {
            reactor?.action.onNext(.imageDidSelected(try? Data(contentsOf: media), filename))
        }
        
        dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
