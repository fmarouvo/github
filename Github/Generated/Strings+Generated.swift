// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Common {
    internal enum Loading {
      /// Please wait...
      internal static let message = L10n.tr("Localizable", "Common.Loading.Message", fallback: "Please wait...")
    }
    internal enum TableView {
      /// Common
      internal static let emptyDataMessage = L10n.tr("Localizable", "Common.TableView.EmptyDataMessage", fallback: "Data is empty. Try again later.")
      /// Pull to refresh
      internal static let refreshControlMessage = L10n.tr("Localizable", "Common.TableView.RefreshControlMessage", fallback: "Pull to refresh")
    }
  }
  internal enum LaunchScreen {
    /// Fausto Castagnari Marouvo
    internal static let credits = L10n.tr("Localizable", "LaunchScreen.Credits", fallback: "Fausto Castagnari Marouvo")
    /// LaunchScreen
    internal static let title = L10n.tr("Localizable", "LaunchScreen.Title", fallback: "GitHub")
  }
  internal enum UserDetails {
    /// Company: %@
    internal static func companyLabel(_ p1: Any) -> String {
      return L10n.tr("Localizable", "UserDetails.CompanyLabel", String(describing: p1), fallback: "Company: %@")
    }
    /// Location: %@
    internal static func locationLabel(_ p1: Any) -> String {
      return L10n.tr("Localizable", "UserDetails.LocationLabel", String(describing: p1), fallback: "Location: %@")
    }
    /// User: %@
    internal static func nameLabel(_ p1: Any) -> String {
      return L10n.tr("Localizable", "UserDetails.NameLabel", String(describing: p1), fallback: "User: %@")
    }
    /// Not Informed
    internal static let notInformed = L10n.tr("Localizable", "UserDetails.NotInformed", fallback: "Not Informed")
    /// Repositories
    internal static let repositories = L10n.tr("Localizable", "UserDetails.Repositories", fallback: "Repositories")
    /// Repository: %@\r
    /// 
    internal static func repository(_ p1: Any) -> String {
      return L10n.tr("Localizable", "UserDetails.Repository", String(describing: p1), fallback: "Repository: %@\r\n")
    }
    internal enum NavigationItem {
      /// UserDetails
      internal static let title = L10n.tr("Localizable", "UserDetails.NavigationItem.title", fallback: "User Profile")
    }
  }
  internal enum UserList {
    internal enum NavigationItem {
      /// UserList
      internal static let title = L10n.tr("Localizable", "UserList.NavigationItem.Title", fallback: "User List")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
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
