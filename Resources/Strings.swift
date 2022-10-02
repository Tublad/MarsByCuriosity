// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// yyyy-M-dd
  internal static let fetchDateFormate = L10n.tr("Localizable", "fetch_date_formate")
  /// https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=%@&camera=%@&api_key=%@
  internal static func link(_ p1: Any, _ p2: Any, _ p3: Any) -> String {
    return L10n.tr("Localizable", "link", String(describing: p1), String(describing: p2), String(describing: p3))
  }
  /// \n
  internal static let newLine = L10n.tr("Localizable", "new_line")

  internal enum Camera {
    /// Chemistry and Camera Complex
    internal static let chemcam = L10n.tr("Localizable", "camera.chemcam")
    /// Front Hazard Avoidance Camera
    internal static let fhaz = L10n.tr("Localizable", "camera.fhaz")
    /// Mars Hand Lens Imager
    internal static let mahli = L10n.tr("Localizable", "camera.mahli")
    /// Mars Descent Imager
    internal static let mardi = L10n.tr("Localizable", "camera.mardi")
    /// Mast Camera
    internal static let mast = L10n.tr("Localizable", "camera.mast")
    /// Miniature Thermal Emission Spectrometer
    internal static let minites = L10n.tr("Localizable", "camera.minites")
    /// Navigation Camera
    internal static let navcam = L10n.tr("Localizable", "camera.navcam")
    /// Panoramic Camera
    internal static let pancam = L10n.tr("Localizable", "camera.pancam")
    /// Rear Hazard Avoidance Camera
    internal static let rhaz = L10n.tr("Localizable", "camera.rhaz")
  }

  internal enum Error {
    internal enum NoInternetConnection {
      /// Check the connection and try again
      internal static let description = L10n.tr("Localizable", "error.no_internet_connection.description")
      /// No Connection
      internal static let title = L10n.tr("Localizable", "error.no_internet_connection.title")
    }
    internal enum NotFound {
      /// Try to change the keyword and try again
      internal static let description = L10n.tr("Localizable", "error.not_found.description")
      /// Found nothing
      internal static let title = L10n.tr("Localizable", "error.not_found.title")
    }
    internal enum SomethingWentWrong {
      /// Something somehow went wrong.\n We’re already working on that
      internal static let description = L10n.tr("Localizable", "error.something_went_wrong.description")
      /// Woah!
      internal static let title = L10n.tr("Localizable", "error.something_went_wrong.title")
    }
  }

  internal enum Main {
    /// Explore
    internal static let buttonExploreTitle = L10n.tr("Localizable", "main.button_explore_title")
    /// Retry
    internal static let buttonRetryTitle = L10n.tr("Localizable", "main.button_retry_title")
    /// Date
    internal static let dateTitle = L10n.tr("Localizable", "main.date_title")
    /// Rover Camera
    internal static let roverCameraTitle = L10n.tr("Localizable", "main.rover_camera_title")
    /// Select Camera and Date
    internal static let title = L10n.tr("Localizable", "main.title")
  }

  internal enum Picker {
    /// Apply
    internal static let applyTitle = L10n.tr("Localizable", "picker.apply_title")
    /// Cancel
    internal static let cancelTitle = L10n.tr("Localizable", "picker.cancel_title")
    /// d MMM, yyyy
    internal static let dateFormate = L10n.tr("Localizable", "picker.date_formate")
    /// en_EN
    internal static let locale = L10n.tr("Localizable", "picker.locale")
    /// Choose Date
    internal static let title = L10n.tr("Localizable", "picker.title")
  }

  internal enum Preview {
    /// Photo ID
    internal static let title = L10n.tr("Localizable", "preview.title")
  }

  internal enum SystemImageName {
    /// gobackward
    internal static let gobackward = L10n.tr("Localizable", "system_image_name.gobackward")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
