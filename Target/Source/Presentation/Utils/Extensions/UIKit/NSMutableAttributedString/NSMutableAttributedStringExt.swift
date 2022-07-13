import UIKit
import Foundation

extension NSMutableAttributedString {
    func insetColorForText(textToFind: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    func insetFontForText(textToFind: String, withFont font: UIFont) {
        let range : NSRange = self.mutableString.range(of: textToFind,options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    }
    func text(_ text: String?) -> NSMutableAttributedString {
        self.append(NSAttributedString(string: text ?? ""))
        return self
    }
    func font(_ font: UIFont?) -> NSMutableAttributedString {
        self.addAttributes([.font: font], range: .init(location: 0, length: self.length))
        return self
    }
    func setColorForText(textToFind: String, withColor color: UIColor) -> NSMutableAttributedString {
        let range: NSRange = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        return self
    }
    func setFontForText(textToFind: String, withFont font: UIFont) -> NSMutableAttributedString {
        let range : NSRange = self.mutableString.range(of: textToFind,options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        return self
    }
}
