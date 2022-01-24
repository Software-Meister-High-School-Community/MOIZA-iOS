// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(OSX)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum MOIZAFontFamily {
  public enum Roboto {
    public static let black = MOIZAFontConvertible(name: "Roboto-Black", family: "Roboto", path: "Roboto-Black.ttf")
    public static let blackItalic = MOIZAFontConvertible(name: "Roboto-BlackItalic", family: "Roboto", path: "Roboto-BlackItalic.ttf")
    public static let bold = MOIZAFontConvertible(name: "Roboto-Bold", family: "Roboto", path: "Roboto-Bold.ttf")
    public static let boldItalic = MOIZAFontConvertible(name: "Roboto-BoldItalic", family: "Roboto", path: "Roboto-BoldItalic.ttf")
    public static let italic = MOIZAFontConvertible(name: "Roboto-Italic", family: "Roboto", path: "Roboto-Italic.ttf")
    public static let light = MOIZAFontConvertible(name: "Roboto-Light", family: "Roboto", path: "Roboto-Light.ttf")
    public static let lightItalic = MOIZAFontConvertible(name: "Roboto-LightItalic", family: "Roboto", path: "Roboto-LightItalic.ttf")
    public static let medium = MOIZAFontConvertible(name: "Roboto-Medium", family: "Roboto", path: "Roboto-Medium.ttf")
    public static let mediumItalic = MOIZAFontConvertible(name: "Roboto-MediumItalic", family: "Roboto", path: "Roboto-MediumItalic.ttf")
    public static let regular = MOIZAFontConvertible(name: "Roboto-Regular", family: "Roboto", path: "Roboto-Regular.ttf")
    public static let thin = MOIZAFontConvertible(name: "Roboto-Thin", family: "Roboto", path: "Roboto-Thin.ttf")
    public static let thinItalic = MOIZAFontConvertible(name: "Roboto-ThinItalic", family: "Roboto", path: "Roboto-ThinItalic.ttf")
    public static let all: [MOIZAFontConvertible] = [black, blackItalic, bold, boldItalic, italic, light, lightItalic, medium, mediumItalic, regular, thin, thinItalic]
  }
  public static let allCustomFonts: [MOIZAFontConvertible] = [Roboto.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct MOIZAFontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(OSX)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

public extension MOIZAFontConvertible.Font {
  convenience init?(font: MOIZAFontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
// swiftlint:enable all
// swiftformat:enable all
