import UIKit
import PinLayout

final class NoticeListVC: BaseVC<NoticeListReactor> {
    // MARK: - Properties
    private let noticeListTableView = UITableView()
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(noticeListTableView)
    }
    override func setLayoutSubViews() {
        noticeListTableView.pin.all(view.pin.safeArea)
    }
    
    // MARK: - Reactor
    
}
