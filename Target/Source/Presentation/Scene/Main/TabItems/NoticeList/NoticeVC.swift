import UIKit
import Then
import PinLayout
import RxSwift
import RxCocoa

final class NoticeListVC: BaseVC<NoticeListReactor> {
    // MARK: - Properties
    private let noticeListTableView = UITableView().then {
        $0.register(NoticeListCell.self, forCellReuseIdentifier: NoticeListCell.reusableID)
        $0.rowHeight = 77
        $0.backgroundColor = MOIZAAsset.moizaGray2.color
        $0.separatorStyle = .none
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(noticeListTableView)
    }
    override func setLayoutSubViews() {
        noticeListTableView.pin.all(view.pin.safeArea)
    }
    override func configureNavigation() {
        self.navigationItem.configBack()
        self.navigationItem.setTitle(title: "공지사항")
    }
    override func darkConfigure() {
        noticeListTableView.backgroundColor = MOIZAAsset.moizaDark1.color
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: NoticeListReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: NoticeListReactor) {
        let sharedStae = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        sharedStae
            .map(\.noticeList)
            .bind(to: noticeListTableView.rx.items(cellIdentifier: NoticeListCell.reusableID, cellType: NoticeListCell.self)) { _, item, cell in
                cell.model = item
            }
            .disposed(by: disposeBag)
    }
}
