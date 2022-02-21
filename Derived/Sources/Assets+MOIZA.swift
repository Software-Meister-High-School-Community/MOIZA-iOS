// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum MOIZAAsset {
  public static let accentColor = MOIZAColors(name: "AccentColor")
  public static let moizaPrimaryYellow = MOIZAColors(name: "MOIZA_Primary_Yellow")
  public static let moizaPrimaryBlue = MOIZAColors(name: "MOIZA_Primary_blue")
  public static let moizaSecondaryBlue = MOIZAColors(name: "MOIZA_Secondary_Blue")
  public static let moizaSecondaryYellow = MOIZAColors(name: "MOIZA_Secondary_Yellow")
  public static let moizaTheme = MOIZAColors(name: "MOIZA_Theme")
  public static let moizaConstGray1 = MOIZAColors(name: "MOIZA_Const_Gray1")
  public static let moizaConstGray2 = MOIZAColors(name: "MOIZA_Const_Gray2")
  public static let moizaConstGray3 = MOIZAColors(name: "MOIZA_Const_Gray3")
  public static let moizaConstGray4 = MOIZAColors(name: "MOIZA_Const_Gray4")
  public static let moizaConstGray5 = MOIZAColors(name: "MOIZA_Const_Gray5")
  public static let moizaConstGray6 = MOIZAColors(name: "MOIZA_Const_Gray6")
  public static let moizaGray1 = MOIZAColors(name: "MOIZA_Gray1")
  public static let moizaGray2 = MOIZAColors(name: "MOIZA_Gray2")
  public static let moizaGray3 = MOIZAColors(name: "MOIZA_Gray3")
  public static let moizaGray4 = MOIZAColors(name: "MOIZA_Gray4")
  public static let moizaGray5 = MOIZAColors(name: "MOIZA_Gray5")
  public static let moizaGray6 = MOIZAColors(name: "MOIZA_Gray6")
  public static let moizaIdea = MOIZAImages(name: "MOIZA_Idea")
  public static let moizaQuestion = MOIZAImages(name: "MOIZA_Question")
  public static let moizaSymbol = MOIZAImages(name: "MOIZA_Symbol")
  public static let moizaBookReader = MOIZAImages(name: "MOIZA_bookReader")
  public static let moizaAlarm = MOIZAImages(name: "MOIZA_Alarm")
  public static let moizaAlarmFill = MOIZAImages(name: "MOIZA_Alarm_Fill")
  public static let moizaHome = MOIZAImages(name: "MOIZA_Home")
  public static let moizaHomeFill = MOIZAImages(name: "MOIZA_Home_Fill")
  public static let moizaPerson = MOIZAImages(name: "MOIZA_Person")
  public static let moizaPersonFill = MOIZAImages(name: "MOIZA_Person_Fill")
  public static let moizaPost = MOIZAImages(name: "MOIZA_Post")
  public static let moizaPostFill = MOIZAImages(name: "MOIZA_Post_Fill")
  public static let moizaLogo = MOIZAImages(name: "MOIZA_Logo")
  public static let moizaLogoDark = MOIZAImages(name: "MOIZA_Logo_Dark")
  public static let moizaLogoLight = MOIZAImages(name: "MOIZA_Logo_Light")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class MOIZAColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension MOIZAColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: MOIZAColors) {
    let bundle = MOIZAResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct MOIZAImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = MOIZAResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

public extension MOIZAImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the MOIZAImages.image property")
  convenience init?(asset: MOIZAImages) {
    #if os(iOS) || os(tvOS)
    let bundle = MOIZAResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:enable all
// swiftformat:enable all
