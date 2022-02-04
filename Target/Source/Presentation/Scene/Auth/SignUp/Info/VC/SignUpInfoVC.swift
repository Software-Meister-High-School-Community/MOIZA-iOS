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
import SnapKit
import FlexLayout
import M13Checkbox
import RxCocoa
import RxDataSources
import RxSwift
import RxKeyboard

final class SignUpInfoVC: baseVC<SignUpInfoReactor>{
    // MARK: - Metric
    enum Fonts {
        static let regular14 = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        static let regular16 = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
    }
    
    enum Metric {
        static let margin: CGFloat = 40
        static let height: CGFloat = 44
        static let labelHeight: CGFloat = 40
    }
    
    // MARK: - Properties
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let rootContainer = UIView()
    private let progressBar = SignUpProgress().then {
        $0.currentIndex = 0
    }
    private let titleLabel = SubTitleLabel(title: "정보 입력")
    
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
    
    private let birthLabel = SignUpCategoryLabel(text: "생년월일 8자리")
    private let birthTextField = SignUpTextField().then {
        $0.tintColor = .clear
    }
    
    private let schoolLabel = SignUpCategoryLabel(text: "학교 선택")
    private let schoolTextField = SignUpTextField().then {
        $0.tintColor = .clear
    }
    
    private let schoolPicker = UIPickerView()
    private let schoolData = [.none, School.gsm, .dgsm, .dsm, .mirim, .bsm]
    
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
        $0.setTitleColor(MOIZAAsset.moizaGray6.color, for: .normal)
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
    
    private let authCodeLabel = SignUpCategoryLabel(text: "인증번호")
    private let authCodeTextField = SignUpTextField()
    private let authCodeRetryLabel = UILabel().then {
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        $0.textColor = MOIZAAsset.moizaTheme.color
        $0.text = "ASd"
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
        progressBar.delegate = self
        genderCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func addView() {
        scrollView.addSubViews(rootContainer)
        view.addSubViews(scrollView)
    }
    override func setLayoutSubViews() {
        scrollView.pin.all()
        rootContainer.pin.top().right().left().height(1000)
        rootContainer.flex.layout()
        scrollView.contentSize = .init(width: bound.width, height: 1000)
    }
    override func setLayout() {
        rootContainer.flex.marginHorizontal(20).define { flex in
            flex.addItem(progressBar).height(10).top(12)
            flex.addItem(titleLabel).height(Metric.labelHeight).marginTop(40)
            // MARK: Division
            flex.addItem().top(Metric.margin * 1).define { flex in
                flex.addItem(divisionLabel).height(Metric.labelHeight).width(100%)
                flex.addItem().horizontally(0).direction(.row).define { flex in
                    flex.addItem().direction(.row).shrink(1).define { flex in
                        flex.addItem(studentRadio).width(24).height(24)
                        flex.addItem(studentLabel).left(10).width(70%).height(24)
                    }
                    flex.addItem().top(5).direction(.row).shrink(1).define { flex in
                        flex.addItem(graduateRadio).width(24).height(24)
                        flex.addItem(graduateLabel).left(10).width(70%).height(24)
                    }
                }
            }
            // MARK: Name
            flex.addItem().top(Metric.margin * 2).define { flex in
                flex.addItem(nameLabel).height(Metric.labelHeight).width(100%)
                flex.addItem().horizontally(0).height(44).direction(.row).define { flex in
                    flex.addItem(nameTextField).width(65%).height(Metric.height)
                    flex.addItem(genderCollectionView).width(88).height(Metric.height).left(10)
                }
            }
            // MARK: Birth
            flex.addItem().top(Metric.margin * 3).define { flex in
                flex.addItem(birthLabel).height(Metric.labelHeight).width(100%)
                flex.addItem(birthTextField).width(100%).height(Metric.height)
            }
            // MARK: School
            flex.addItem().top(Metric.margin * 4).define { flex in
                flex.addItem(schoolLabel).height(Metric.labelHeight).width(100%)
                flex.addItem(schoolTextField).height(Metric.height).width(100%)
            }
            // MARK: Email
            flex.addItem().top(Metric.margin * 5).define { flex in
                flex.addItem(emailLabel).height(Metric.labelHeight).width(100%)
                flex.addItem().direction(.row).width(100%).height(Metric.height).define { flex in
                    flex.addItem(emailTextField).width(40%).height(Metric.height)
                    flex.addItem(emailMiddleLabel).height(Metric.height).width(14).marginLeft(5)
                    flex.addItem(emailTypeTextField).height(Metric.height).width(25%).marginLeft(5)
                    flex.addItem(authRequestButton).height(Metric.height).width(23%).marginLeft(5)
                }
                flex.addItem(emailHelperLabel).top(10).width(100%).minHeight(0).maxHeight(Metric.height)
            }
            // MARK: AuthCode
            flex.addItem().top(Metric.margin * 6).define { flex in
                flex.addItem(authCodeLabel).height(Metric.labelHeight).width(100%)
                flex.addItem(authCodeTextField).height(Metric.labelHeight).width(100%)
                flex.addItem(authCodeRetryLabel).height(Metric.labelHeight).width(100%)
            }
            // MARK: Next
            flex.addItem(nextButton).top(Metric.margin * 7).width(88).height(36).right(0).alignSelf(.end)
        }
    }
    override func configureVC() {
        scrollView.backgroundColor = MOIZAAsset.moizaGray1.color
        
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
        
        self.navigationItem.configBack()
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: SignUpInfoReactor) {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] kbHeight in
                guard let self = self else { return }
                let height = kbHeight > 0 ? -kbHeight + self.view.safeAreaInsets.bottom : 0
                UIView.animate(withDuration: 0) {
                    self.scrollView.pin.bottom(-height)
                }
            })
            .disposed(by: disposeBag)
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
            .withUnretained(self)
            .map{ $0.0.datePicker.date }
            .map(Reactor.Action.updateBirth)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        schoolPicker.rx.itemSelected
            .map(\.row)
            .withUnretained(self)
            .map { $0.0.schoolData[$0.1] }
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
