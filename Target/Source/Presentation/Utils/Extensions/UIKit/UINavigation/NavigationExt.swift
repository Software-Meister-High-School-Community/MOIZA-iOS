import UIKit

extension UINavigationItem{
    func setTitle(title: String){
        let lb = UILabel()
        lb.text = title
        lb.textColor = MOIZAAsset.moizaGray6.color
        lb.font = UIFont(font: MOIZAFontFamily.Roboto.regular, size: 14)
        self.titleView = lb
    }
    func setTitleWithSubTitle(title: String, subtitle: String) {
        let lb = UILabel()
        let str = NSMutableAttributedString(string: "\(title)\n\(subtitle)")
        str.insetFontForText(textToFind: title, withFont: UIFont(font: MOIZAFontFamily.Roboto.bold, size: 12) ?? .init())
        str.insetFontForText(textToFind: subtitle, withFont: UIFont(font: MOIZAFontFamily.Roboto.regular, size: 12) ?? .init())
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.textColor = MOIZAAsset.moizaGray6.color
        lb.attributedText = str
        self.titleView = lb
    }
    func configAuthNavigation(title: String){
        self.setTitle(title: title)
        let symbol = UIBarButtonItem(image: MOIZAAsset.moizaSymbol.image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        self.rightBarButtonItem = symbol
    }
    func configBack(){
        let back = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        back.tintColor = MOIZAAsset.moizaGray6.color
        self.backBarButtonItem = back
    }
    func configLeftLogo(){
        let leftLogo = UIBarButtonItem(image: MOIZAAsset.moizaLogo.image.downSample(size: .init(width: 40, height: 40)).withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        self.leftBarButtonItem = leftLogo
    }
}
