// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum GCMSFontFamily {
  public enum Inter {
    public static let black = GCMSFontConvertible(name: "Inter-Black", family: "Inter", path: "Inter-Black.ttf")
    public static let bold = GCMSFontConvertible(name: "Inter-Bold", family: "Inter", path: "Inter-Bold.ttf")
    public static let extraBold = GCMSFontConvertible(name: "Inter-ExtraBold", family: "Inter", path: "Inter-ExtraBold.ttf")
    public static let extraLight = GCMSFontConvertible(name: "Inter-ExtraLight", family: "Inter", path: "Inter-ExtraLight.ttf")
    public static let light = GCMSFontConvertible(name: "Inter-Light", family: "Inter", path: "Inter-Light.ttf")
    public static let medium = GCMSFontConvertible(name: "Inter-Medium", family: "Inter", path: "Inter-Medium.ttf")
    public static let regular = GCMSFontConvertible(name: "Inter-Regular", family: "Inter", path: "Inter-Regular.ttf")
    public static let semiBold = GCMSFontConvertible(name: "Inter-SemiBold", family: "Inter", path: "Inter-SemiBold.ttf")
    public static let thin = GCMSFontConvertible(name: "Inter-Thin", family: "Inter", path: "Inter-Thin.ttf")
    public static let all: [GCMSFontConvertible] = [black, bold, extraBold, extraLight, light, medium, regular, semiBold, thin]
  }
  public enum SassyFrass {
    public static let regular = GCMSFontConvertible(name: "SassyFrass-Regular", family: "Sassy Frass", path: "SassyFrass-Regular.ttf")
    public static let all: [GCMSFontConvertible] = [regular]
  }
  public static let allCustomFonts: [GCMSFontConvertible] = [Inter.all, SassyFrass.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct GCMSFontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(macOS)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    #if os(macOS)
    return SwiftUI.Font.custom(font.fontName, size: font.pointSize)
    #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    return SwiftUI.Font(font)
    #endif
  }
  #endif

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return Bundle.module.url(forResource: path, withExtension: nil)
  }
}

public extension GCMSFontConvertible.Font {
  convenience init?(font: GCMSFontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(macOS)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}
// swiftlint:enable all
// swiftformat:enable all
