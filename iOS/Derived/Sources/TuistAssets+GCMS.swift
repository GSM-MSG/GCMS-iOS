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
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum GCMSAsset {
  public enum Colors {
    public static let gcmsBackgroundColor = GCMSColors(name: "GCMS_BackgroundColor")
    public static let gcmsMainColor = GCMSColors(name: "GCMS_MainColor")
    public static let gcmsOnBoardingMainColor = GCMSColors(name: "GCMS_OnBoardingMainColor")
    public static let gcmsThemeColor = GCMSColors(name: "GCMS_ThemeColor")
    public static let gcmsGray1 = GCMSColors(name: "GCMS_Gray1")
    public static let gcmsGray2 = GCMSColors(name: "GCMS_Gray2")
    public static let gcmsGray3 = GCMSColors(name: "GCMS_Gray3")
    public static let gcmsGray4 = GCMSColors(name: "GCMS_Gray4")
    public static let gcmsGray5 = GCMSColors(name: "GCMS_Gray5")
    public static let gcmsGray6 = GCMSColors(name: "GCMS_Gray6")
  }
  public enum Images {
    public static let gcmsEditorial = GCMSImages(name: "GCMS_Editorial")
    public static let gcmsEditorialGray = GCMSImages(name: "GCMS_Editorial_Gray")
    public static let gcmsFreedom = GCMSImages(name: "GCMS_Freedom")
    public static let gcmsFreedomGray = GCMSImages(name: "GCMS_Freedom_gray")
    public static let gcmsgLogo = GCMSImages(name: "GCMS_GLogo")
    public static let gcmsGoogleLogo = GCMSImages(name: "GCMS_GoogleLogo")
    public static let gcmsMail = GCMSImages(name: "GCMS_Mail")
    public static let gcmsMajor = GCMSImages(name: "GCMS_Major")
    public static let gcmsMajorGray = GCMSImages(name: "GCMS_Major_Gray")
    public static let gcmsNewClubPlaceholder = GCMSImages(name: "GCMS_NewClubPlaceholder")
    public static let gcmsWhaleLogo = GCMSImages(name: "GCMS_WhaleLogo")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class GCMSColors {
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

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension GCMSColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: GCMSColors) {
    let bundle = GCMSResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: GCMSColors) {
    let bundle = GCMSResources.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct GCMSImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = GCMSResources.bundle
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

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension GCMSImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the GCMSImages.image property")
  convenience init?(asset: GCMSImages) {
    #if os(iOS) || os(tvOS)
    let bundle = GCMSResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: GCMSImages) {
    let bundle = GCMSResources.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: GCMSImages, label: Text) {
    let bundle = GCMSResources.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: GCMSImages) {
    let bundle = GCMSResources.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
