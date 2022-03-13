import UIKit
import PinLayout
import FlexLayout

final class DetailPostVC: baseVC<DetailPostReactor> {
    // MARK: - Properties
    private let headerContainer = UIView().then {
        $0.backgroundColor = MOIZAAsset.moizaConstGray1.color
        $0.layer.cornerRadius = 20
    }
    private let titleLabe = UILabel().then {
        $0.text = "ASDFASDFASDFASDFASDFASDFASDFASDFASDFASDFASFASDF"
        $0.numberOfLines = 0
    }
    private let writtenLabel = UILabel()
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = true
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
    }
    private let userInfoLabel = UILabel()
    private let contentLabel = UILabel()
    private let likeButton = UIButton()
    
    private let commentTableView = UITableView().then {
        $0.register(CommentCell.self, forCellReuseIdentifier: CommentCell.reusableID)
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(headerContainer)
    }
    override func setLayoutSubViews() {
        headerContainer.pin.width(100%)
        
        headerContainer.flex.layout(mode: .adjustHeight)
    }
    override func setLayout() {
        
    }
    
    // MARK: - UI
    override func configureNavigation() {
        self.navigationItem.configBack()
        self.navigationItem.setTitleWithSubTitle(
            title: UserDefaultsLocal.shared.major.display,
            subtitle: "질문 게시판"
        )
    }
}
