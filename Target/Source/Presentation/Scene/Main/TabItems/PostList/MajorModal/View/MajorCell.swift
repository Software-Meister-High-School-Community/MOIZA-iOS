import UIKit
import PinLayout
import RxSwift

final class MajorCell: BaseTableViewCell<Major> {
    // MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.textColor = MOIZAAsset.moizaGray5.color
        $0.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 16)
        $0.textAlignment = .center
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
        disposeBag = DisposeBag()
    }
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(titleLabel)
    }
    override func setLayoutSubviews() {
        titleLabel.pin.all()
    }
    override func darkConfigure() {
        self.backgroundColor = MOIZAAsset.moizaDark2.color
    }
    
    override func bind(_ model: Major) {
        titleLabel.text = model.display
    }
}
