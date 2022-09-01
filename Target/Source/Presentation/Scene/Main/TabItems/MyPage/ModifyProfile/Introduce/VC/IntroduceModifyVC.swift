
import UIKit
import RxDataSources
import RxSwift
import RxViewController
import PinLayout
import RxCocoa
import FlexLayout

final class IntroduceModifyVC: BaseVC<IntroduceModifyReactor>{
    
    private let mainContainer = UIView()
    
    private let nextButton = NextButton(title: "확인")
    
    private let introduceTextfield = UITextField().then{
        $0.backgroundColor = MOIZAAsset.moizaGray1.color
        $0.font = UIFont(name: MOIZAFontFamily.Roboto.regular.family, size: 13)
        $0.textColor = MOIZAAsset.moizaGray6.color
        $0.text = "안녕하세요 박재만입니다"
        $0.leftSpace(14)
    }
    
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    
    override func configureNavigation() {
        self.navigationItem.setTitle(title: "소개")
    }
    
    override func addView() {
        view.addSubViews(mainContainer)
    }
    
    override func setLayoutSubViews() {
        mainContainer.pin.all(view.pin.safeArea)
        mainContainer.flex.layout()
    }
    override func setLayout() {
        mainContainer.flex.marginHorizontal(16).define { flex in
            flex.addItem(introduceTextfield).marginTop(20).alignSelf(.center).width(100%).height(45)
            flex.addItem(nextButton).marginTop(20).width(50).height(28).alignSelf(.end)
        }
    }
    override func bindView(reactor: IntroduceModifyReactor) {
        nextButton.rx.tap
            .map { Reactor.Action.nextButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
