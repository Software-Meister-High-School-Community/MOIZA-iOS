//
//  GraduateFileVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/02/08.
//  Copyright © 2022 com.connect. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout
import FlexibleSteppedProgressBar
import RxCocoa
import RxSwift
import UniformTypeIdentifiers
import Photos

final class GraduateFileVC: baseVC<GraduateFileReactor> {
    // MARK: - Properties
    private let progressBar = SignUpProgress().then {
        $0.numberOfPoints = 2
    }
    private let rootContainer = UIView()
    private let fileAttachLabel = UILabel().then {
        $0.text = "필수 파일 첨부"
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        $0.textColor = MOIZAAsset.moizaGray6.color
    }
    private let attachButton = UIButton().then {
        $0.setTitle("+", for: .normal)
        $0.setTitleColor(MOIZAAsset.moizaGray4.color, for: .normal)
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15.5
    }
    private let fileNameLabel = UILabel().then {
        $0.textColor = MOIZAAsset.moizaGray5.color
        $0.backgroundColor = MOIZAAsset.moizaGray3.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 10)
        $0.textAlignment = .center
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15.5
        $0.flex.display(.none)
    }
    private let cancelButton = UIButton().then {
        $0.setImage(.init(systemName: "xmark")?.downSample(size: .init(width: 7, height: 7)).tintColor(MOIZAAsset.moizaGray5.color),
                    for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 10)
        $0.setTitleColor(MOIZAAsset.moizaGray4.color, for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.flex.display(.none)
        $0.backgroundColor = .clear
    }
    private let descriptionLabel = UILabel().then {
        $0.text = "졸업사진, 졸업장, 학생증 등 재학 이력을 증명할 수 있는 사진은 무엇이든 제출가능합니다."
        $0.numberOfLines = 0
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 10)
        $0.textColor = MOIZAAsset.moizaGray5.color
    }
    private let requestButton = NextButton(title: "인증 신청")
    
    private let imagePicker = UIImagePickerController().then {
        $0.allowsEditing = true
    }
    
    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        progressBar.currentIndex = 1
        
    }
    
    // MARK: - UI
    override func setUp() {
        progressBar.delegate = self
        imagePicker.delegate = self
    }
    override func addView() {
        view.addSubViews(rootContainer)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.marginHorizontal(16).define { flex in
            flex.addItem(progressBar).top(12).height(10).marginHorizontal(4)
            flex.addItem(fileAttachLabel).marginTop(70)
            flex.addItem(attachButton).direction(.row).width(100%).height(28).marginTop(20).define { flex in
                flex.addItem(fileNameLabel).width(70%).height(100%).left(0)
                flex.addItem(cancelButton).marginRight(5).height(28).width(30%)
            }
            flex.addItem(descriptionLabel).width(100%).marginTop(20)
            flex.addItem(requestButton).alignSelf(.end).marginTop(45).width(88).height(36)
        }
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "졸업생 인증")
        self.navigationItem.configBack()
    }
    override func darkConfigure() {
        descriptionLabel.textColor = MOIZAAsset.moizaDark2.color
        attachButton.backgroundColor = MOIZAAsset.moizaDark2.color
        attachButton.layer.borderColor = UIColor.clear.cgColor
        fileNameLabel.backgroundColor = MOIZAAsset.moizaDark4.color
    }
    // MARK: - Reactor
    override func bindView(reactor: GraduateFileReactor) {
        attachButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.photoAndCameraAction()
            })
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .map { Reactor.Action.cancelButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        requestButton.rx.tap
            .map { Reactor.Action.requestButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: GraduateFileReactor) {
        let sharedState = reactor.state.share(replay: 3).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.fileName)
            .bind(to: fileNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.fileSize)
            .asDriver(onErrorJustReturn: "0 MB")
            .drive(cancelButton.rx.title())
            .disposed(by: disposeBag)
        
        sharedState
            .map{ $0.selectedData != nil }
            .withUnretained(self)
            .subscribe(onNext: { owner, isExist in
                [owner.fileNameLabel, owner.cancelButton].forEach{ $0.flex.display(isExist ? .flex : .none) }
                owner.requestButton.backgroundColor = isExist ? MOIZAAsset.moizaPrimaryBlue.color : MOIZAAsset.moizaSecondaryBlue.color
                owner.requestButton.isEnabled = isExist
                owner.rootContainer.flex.layout()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Method
private extension GraduateFileVC {
    func photoAndCameraAction() {
        
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
// MARK: - Extension
// MARK: FlexibleSteppedProgressBar
extension GraduateFileVC: FlexibleSteppedProgressBarDelegate {
    func progressBar(_ progressBar: FlexibleSteppedProgressBar, textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
        return ""
    }
}

// MARK: UIImagePicker
extension GraduateFileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
