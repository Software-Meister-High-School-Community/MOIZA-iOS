//
//  SignUpInfoVC.swift
//  MOIZA
//
//  Created by 최형우 on 2022/01/25.
//  Copyright © 2022 com.connect. All rights reserved.
//

import FlexibleSteppedProgressBar
import SwiftDate
import Hero
import PinLayout
import Then
import UIKit
import FlexLayout
import M13Checkbox
import RxCocoa
import RxDataSources
import RxSwift

final class SignUpInfoVC: baseVC<SignUpInfoReactor>{
    // MARK: - Metric
    enum Fonts {
        static let regular14 = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        static let regular16 = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
    }
    
    enum Metric {
        static let margin: CGFloat = 12
        static let height: CGFloat = 44
        static let labelHeight: CGFloat = 30
    }
    
    // MARK: - Properties
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let progressBar = SignUpProgress().then {
        $0.currentIndex = 0
    }
    private let titleLabel = SubTitleLabel(title: "정보 입력")
    
    private let divisionContainer = UIView()
    private let divisionLabel = SignUpCategoryLabel(text: "구분")
    private let studentRadio = MoizaRadioButton().then {
        $0.checkState = .checked
    }
    private let studentLabel = UILabel().then {
        $0.text = StudentKind.student.rawValue
        $0.font = Fonts.regular14
    }
    private let graduateRadio = MoizaRadioButton()
    private let graduateLabel = UILabel().then {
        $0.text = StudentKind.graduate.rawValue
        $0.font = Fonts.regular14
    }
    
    private let nameContainer = UIView()
    private let nameLabel = SignUpCategoryLabel(text: "이름")
    private let nameTextField = SignUpTextField()
    private let genderCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        $0.isScrollEnabled = false
        $0.collectionViewLayout = layout
        $0.register(GenderCell.self, forCellWithReuseIdentifier: GenderCell.reusableID)
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        $0.allowsMultipleSelection = false
    }
    
    private let birthContainer = UIView()
    private let birthLabel = SignUpCategoryLabel(text: "생년월일 8자리")
    private let birthTextField = SignUpTextField()
    
    private let schoolContainer = UIView()
    private let schoolLabel = SignUpCategoryLabel(text: "학교 선택")
    private let schoolTextField = SignUpTextField()
    
    private let schoolPicker = UIPickerView()
    private let schoolData = [.none, School.gsm, .dgsm, .dsm, .mirim, .bsm]
    
    private let emailContainer = UIView()
    private let emailLabel = SignUpCategoryLabel(text: "학교 이메일")
    private let emailTextField = SignUpTextField()
    private let emailMiddleLabel = UILabel().then {
        $0.text = "@"
        $0.font = Fonts.regular14
        $0.textColor = MOIZAAsset.moizaGray5.color
    }
    private let emailTypeTextField = SignUpTextField()
    private let authRequestButton = UIButton().then {
        $0.setTitle("인증 요청", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.medium, size: 14)
        $0.titleLabel?.textAlignment = .center
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = MOIZAAsset.moizaGray4.color.cgColor
    }
    private let emailHelperLabel = UILabel().then {
        $0.isHidden = true
        $0.text = "학교 이메일이 만료될 수 있으므로 일반 이메일 입력을 권장합니다."
        $0.numberOfLines = 0
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.textColor = MOIZAAsset.moizaGray4.color
    }
    
    private let authContainer = UIView()
    private let authCodeLabel = SignUpCategoryLabel(text: "인증번호")
    private let authCodeTextField = SignUpTextField()
    private let authCodeRetryLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.textColor = MOIZAAsset.moizaTheme.color
    }
    private let nextButton = NextButton(title: "다음 단계")
    
    private let datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "Ko_kr")
    }
    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        progressBar.currentIndex = 1
        nextButton.hero.id = "progress"
    }
    
    // MARK: - UI
    override func setUp() {
        birthTextField.inputView = datePicker
        schoolTextField.inputView = schoolPicker
        bind(reactor: reactor)
        progressBar.delegate = self
        genderCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func addView() {
        scrollView.addSubViews(progressBar, titleLabel, divisionContainer, nameContainer, birthContainer, schoolContainer, emailContainer, authContainer, nextButton)
        view.addSubViews(scrollView)
    }
    override func setLayout() {
        scrollView.pin.all(view.safeAreaInsets)
        scrollView.contentSize = .init(width: bound.width, height: 1200)
        progressBar.pin.top(12).horizontally(20).height(10)
        titleLabel.pin.below(of: progressBar, aligned: .left).pinEdges().marginTop(30).width(of: progressBar).sizeToFit(.width)
        divisionContainer.pin.below(of: titleLabel, aligned: .left).pinEdges().height(120).width(of: titleLabel).marginTop(Metric.margin)
        nameContainer.pin.below(of: divisionContainer, aligned: .left).height(120).width(of: titleLabel).marginTop(Metric.margin)
        birthContainer.pin.below(of: nameContainer, aligned: .left).height(120).width(of: titleLabel).marginTop(Metric.margin)
        schoolContainer.pin.below(of: birthContainer, aligned: .left).height(120).width(of: titleLabel).marginTop(Metric.margin)
        emailContainer.pin.below(of: schoolContainer, aligned: .left).height(120).width(of: titleLabel).marginTop(Metric.margin)
        authContainer.pin.below(of: emailContainer, aligned: .left).height(120).width(of: titleLabel).marginTop(Metric.margin)
        nextButton.pin.below(of: authContainer, aligned: .right).width(88).height(36).marginTop(Metric.margin)
        
        divisionContainer.flex.define { flex in
            flex.addItem(divisionLabel).height(Metric.labelHeight).width(100%)
            flex.addItem().top(15).horizontally(0).direction(.row).define { flex in
                flex.addItem().direction(.row).shrink(1).define { flex in
                    flex.addItem(studentRadio).width(24).height(24)
                    flex.addItem(studentLabel).left(10).width(70%).height(24)
                }
                flex.addItem().direction(.row).shrink(1).define { flex in
                    flex.addItem(graduateRadio).width(24).height(24)
                    flex.addItem(graduateLabel).left(10).width(70%).height(24)
                }
            }
        }
        nameContainer.flex.define { flex in
            flex.addItem(nameLabel).height(Metric.height).width(100%)
            flex.addItem().horizontally(0).height(44).direction(.row).define { flex in
                flex.addItem(nameTextField).width(65%).height(Metric.height)
                flex.addItem(genderCollectionView).width(88).height(Metric.height).left(10)
            }
        }
        birthContainer.flex.define { flex in
            flex.addItem(birthLabel).height(Metric.height).width(100%)
            flex.addItem(birthTextField).width(100%).height(Metric.height)
        }
        schoolContainer.flex.define { flex in
            flex.addItem(schoolLabel).height(Metric.height).width(100%)
            flex.addItem(schoolTextField).height(Metric.height).width(100%)
        }
        emailContainer.flex.define { flex in
            flex.addItem(emailLabel).height(Metric.height).width(100%)
            flex.addItem().direction(.row).width(100%).height(Metric.height).define { flex in
                flex.addItem(emailTextField).width(40%).height(Metric.height)
                flex.addItem(emailMiddleLabel).height(Metric.height).width(14).marginLeft(5)
                flex.addItem(emailTypeTextField).height(Metric.height).width(25%).marginLeft(5)
                flex.addItem(authRequestButton).height(Metric.height).width(23%).marginLeft(5)
            }
            flex.addItem(emailHelperLabel).top(10).width(100%).minHeight(0).maxHeight(Metric.height)
        }
        authContainer.flex.define { flex in
            flex.addItem(authCodeLabel).height(Metric.height).width(100%)
            flex.addItem(authCodeTextField).width(100%).height(Metric.height)
            flex.addItem(authCodeRetryLabel).width(100%).height(Metric.labelHeight)
        }
        
        
        
        divisionContainer.flex.layout()
        nameContainer.flex.layout(mode: .adjustHeight)
        birthContainer.flex.layout()
        schoolContainer.flex.layout()
        emailContainer.flex.layout()
        authContainer.flex.layout()
    }
    override func configureVC() {
        let genDS = RxCollectionViewSectionedReloadDataSource<GenderSection>{ _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: GenderCell.reusableID, for: ip) as? GenderCell else { return .init() }
            cell.model = item
            return cell
        }
        
        
        Observable.just([Gender.male, Gender.female])
            .map { [GenderSection.init(header: "", items: $0)] }
            .bind(to: genderCollectionView.rx.items(dataSource: genDS))
            .disposed(by: disposeBag)
        
        Observable.just(self.schoolData)
            .bind(to: schoolPicker.rx.itemTitles) { _, item in
                return "\(item.rawValue)"
            }
            .disposed(by: disposeBag)
        
    }
    override func configureNavigation() {
        self.navigationItem.configAuthNavigation(title: "회원가입")
        
        let back = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        back.tintColor = .black
        self.navigationItem.backBarButtonItem = back
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: SignUpInfoReactor) {
        
    }
    override func bindView(reactor: SignUpInfoReactor) {
        genderCollectionView.rx.modelSelected(Gender.self)
            .map(Reactor.Action.genderButtonDidTap)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        studentRadio.rx.controlEvent(.valueChanged)
            .map { Reactor.Action.studentKindButtonDidTap(.student) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        graduateRadio.rx.controlEvent(.valueChanged)
            .map { Reactor.Action.studentKindButtonDidTap(.graduate) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nameTextField.rx.text
            .orEmpty
            .map(Reactor.Action.updateName)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        datePicker.rx.controlEvent(.valueChanged)
            .map{ self.datePicker.date }
            .map(Reactor.Action.updateBirth)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        schoolPicker.rx.itemSelected
            .map(\.row)
            .map { self.schoolData[$0] }
            .map(Reactor.Action.updateSchool)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .orEmpty
            .map(Reactor.Action.updateEmail)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        emailTypeTextField.rx.text
            .orEmpty
            .map(Reactor.Action.updateEmailType)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        authCodeTextField.rx.text
            .orEmpty
            .map(Reactor.Action.updateAuthCode)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .map{ Reactor.Action.nextButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: SignUpInfoReactor) {
        let sharedState = reactor.state.share(replay: 4).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.studentKind)
            .map { $0 == .student }
            .withUnretained(self)
            .subscribe(onNext: { owner, item in
                owner.studentRadio.checkState = item ? .checked : .unchecked
                owner.graduateRadio.checkState = item ? .unchecked : .checked
                owner.emailTypeTextField.isEnabled = !item
                owner.emailHelperLabel.isHidden = item
                owner.emailLabel.text = item ? "학교 이메일" : "이메일"
            })
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.school)
            .withUnretained(self)
            .subscribe(onNext: { owner, item in
                owner.emailTypeTextField.text = item.toDomain()
                owner.schoolTextField.text = item.rawValue
            })
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.signUpValid)
            .withUnretained(self)
            .subscribe(onNext: { owner, item in
                owner.nextButton.isEnabled = item
                owner.nextButton.backgroundColor = item ? MOIZAAsset.moizaPrimaryBlue.color : MOIZAAsset.moizaSecondaryBlue.color
            })
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.birth)
            .map { $0.toString(.custom("yyyy/MM/dd"))}
            .bind(to: birthTextField.rx.text)
            .disposed(by: disposeBag)
    }
}

// MARK: - Extension
extension SignUpInfoVC: FlexibleSteppedProgressBarDelegate{
    func progressBar(_ progressBar: FlexibleSteppedProgressBar, textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
        return ""
    }
}

extension SignUpInfoVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 44, height: 44)
    }
}
