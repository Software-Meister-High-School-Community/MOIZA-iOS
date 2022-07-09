import UIKit

final class SortButton: UIButton {
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        self.setTitle("정렬", for: .normal)
        self.setTitleColor(MOIZAAsset.moizaGray5.color, for: .normal)
        self.titleLabel?.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12)
        self.setImage(MOIZAAsset.moizaFunnel.image.tintColor(MOIZAAsset.moizaConstGray3.color), for: .normal)
        self.layer.cornerRadius = 5
        self.layer.borderColor = MOIZAAsset.moizaGray3.color.cgColor
        self.layer.borderWidth = 1
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = MOIZAAsset.moizaGray1.color
            config.contentInsets = .init(top: 7, leading: 15, bottom: 7, trailing: 15)
            config.imagePadding = 5
            self.configuration = config
        } else {
            self.contentEdgeInsets = .init(top: 7, left: 15, bottom: 7, right: 15)
            self.setBackgroundColor(MOIZAAsset.moizaGray1.color, for: .normal)
        }
        if traitCollection.userInterfaceStyle == .dark {
            self.setTitleColor(MOIZAAsset.moizaDark5.color, for: .normal)
            self.layer.borderColor = UIColor.clear.cgColor
            if #available(iOS 15.0, *) {
                self.configuration?.baseBackgroundColor = MOIZAAsset.moizaDark3.color
            } else {
                self.setBackgroundColor(MOIZAAsset.moizaDark3.color, for: .normal)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
