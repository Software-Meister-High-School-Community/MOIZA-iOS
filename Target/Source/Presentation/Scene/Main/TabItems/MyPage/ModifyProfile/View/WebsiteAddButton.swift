
import UIKit

final class WebsiteAddButton: UIButton{
    
    init(){
        super.init(frame: .zero)
        self.setTitle("링크 추가", for: .normal)
        self.setTitleColor(MOIZAAsset.moizaGray6.color, for: .normal)
        self.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.thin, size: 14)
        self.setImage(UIImage(systemName: "plus"), for: .normal)
        self.tintColor = MOIZAAsset.moizaGray6.color
        self.layer.cornerRadius = 10
        self.contentEdgeInsets = .init(top: 11, left: 8, bottom: 11, right: 8)
        self.setBackgroundColor(MOIZAAsset.moizaGray3.color, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
