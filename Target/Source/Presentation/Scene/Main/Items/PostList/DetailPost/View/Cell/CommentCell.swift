import UIKit
import PinLayout
import FlexLayout

final class CommentCell: baseTableViewCell<Comment> {
    // MARK: - Properties
    private let rootContainer = UIView()
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(rootContainer)
    }
    override func setLayoutSubviews() {
        rootContainer.pin.all()
        
        rootContainer.flex.layout()
    }
    override func setLayout() {
        rootContainer.flex.marginVertical(12.5).define { flex in
            
        }
    }
    override func configureCell() {
        
    }
}
