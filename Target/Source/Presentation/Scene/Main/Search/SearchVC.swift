import UIKit
import PinLayout
import FlexLayout
import Foundation
import Then

final class SearchVC: baseVC<SearchReactor> {
    // MARK: - Metrict
    enum Metric {
        static let marginHorizontal: CGFloat = 16
    }
    enum Font {
        static let recentSearchTextFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        static let allRemoveButtonFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        static let searchTextFieldFont = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
    }
    enum Color {
        static let searchTextFieldBorderColor = MOIZAAsset.moizaPrimaryBlue.color
        static let recentSearchTextColor = MOIZAAsset.moizaGray4.color
        static let allRemoveButtonTextColor = MOIZAAsset.moizaGray4.color
    }
    
    // MARK: - Properties
    private let rootContainer = UIView()
    private let searchTextField = UITextField().then {
        $0.placeholder = "검색어를 입력하세요"
        $0.layer.borderWidth = 3
        $0.layer.borderColor = Color.searchTextFieldBorderColor.cgColor
        $0.layer.cornerRadius = 5
        $0.leftSpace(14)
        $0.font = Font.searchTextFieldFont
    }
    private let searchButton = UIButton().then {
        $0.setImage(.init(systemName: "magnifyingglass")?.tintColor(MOIZAAsset.moizaConstGray1.color), for: .normal)
        $0.backgroundColor = MOIZAAsset.moizaPrimaryBlue.color
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    private let recentSearchLabel = UILabel().then {
        $0.text = "최근 검색어"
        $0.font = Font.recentSearchTextFont
        $0.textColor = Color.recentSearchTextColor
    }
    private let allRemoveButton = UIButton().then {
        $0.setTitle("전체삭제", for: .normal)
        $0.setTitleColor(Color.allRemoveButtonTextColor, for: .normal)
        $0.titleLabel?.font = Font.allRemoveButtonFont
    }
    private let recentSearchTableView = UITableView().then {
        $0.backgroundColor = .clear
    }
    
    // MARK: - UI
    override func setUp() {
        searchButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        searchTextField.rightView = searchButton
        searchTextField.rightViewMode = .always
    }
    override func addView() {
        view.addSubViews(rootContainer)
    }
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.define { flex in
            flex.addItem(searchTextField).marginTop(20).marginHorizontal(Metric.marginHorizontal).height(45)
            flex.addItem().direction(.row).marginTop(47).marginHorizontal(Metric.marginHorizontal).define { flex in
                flex.addItem(recentSearchLabel)
                flex.addItem().grow(1)
                flex.addItem(allRemoveButton)
            }
            flex.addItem(recentSearchTableView).marginTop(10).marginHorizontal(Metric.marginHorizontal).grow(1)
        }
    }
    override func configureVC() {
        view.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    override func configureNavigation() {
        self.navigationItem.setTitle(title: "검색")
    }
}
