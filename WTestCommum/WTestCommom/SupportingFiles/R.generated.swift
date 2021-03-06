//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift

/// This `R` struct is generated and contains references to static resources.
public struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  public static func validate() throws {
    try intern.validate()
  }

  /// This `R.file` struct is generated, and contains static references to 1 files.
  public struct file {
    /// Resource file `Config.plist`.
    public static let configPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "Config", pathExtension: "plist")

    /// `bundle.url(forResource: "Config", withExtension: "plist")`
    public static func configPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.configPlist
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  public struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 9 localization keys.
    public struct localizable {
      /// en translation: Alert
      ///
      /// Locales: en
      public static let alert = Rswift.StringResource(key: "Alert", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: An error occured while trying to fetch postal codes.
      ///
      /// Locales: en
      public static let postalCodesDownloadError = Rswift.StringResource(key: "PostalCodesDownloadError", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Cancel
      ///
      /// Locales: en
      public static let cancel = Rswift.StringResource(key: "Cancel", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Downloading postal codes
      ///
      /// Locales: en
      public static let downloadingLabel = Rswift.StringResource(key: "DownloadingLabel", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Main Menu
      ///
      /// Locales: en
      public static let mainScreenTitle = Rswift.StringResource(key: "MainScreenTitle", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Ok
      ///
      /// Locales: en
      public static let ok = Rswift.StringResource(key: "Ok", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Postal Codes
      ///
      /// Locales: en
      public static let postalCodes = Rswift.StringResource(key: "PostalCodes", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Saving postal codes
      ///
      /// Locales: en
      public static let savingLabel = Rswift.StringResource(key: "SavingLabel", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: WTTest for VIPER
      ///
      /// Locales: en
      public static let appTitle = Rswift.StringResource(key: "App Title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)

      /// en translation: Alert
      ///
      /// Locales: en
      public static func alert(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Alert", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Alert"
        }

        return NSLocalizedString("Alert", bundle: bundle, comment: "")
      }

      /// en translation: An error occured while trying to fetch postal codes.
      ///
      /// Locales: en
      public static func postalCodesDownloadError(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("PostalCodesDownloadError", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "PostalCodesDownloadError"
        }

        return NSLocalizedString("PostalCodesDownloadError", bundle: bundle, comment: "")
      }

      /// en translation: Cancel
      ///
      /// Locales: en
      public static func cancel(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Cancel", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Cancel"
        }

        return NSLocalizedString("Cancel", bundle: bundle, comment: "")
      }

      /// en translation: Downloading postal codes
      ///
      /// Locales: en
      public static func downloadingLabel(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("DownloadingLabel", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "DownloadingLabel"
        }

        return NSLocalizedString("DownloadingLabel", bundle: bundle, comment: "")
      }

      /// en translation: Main Menu
      ///
      /// Locales: en
      public static func mainScreenTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("MainScreenTitle", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "MainScreenTitle"
        }

        return NSLocalizedString("MainScreenTitle", bundle: bundle, comment: "")
      }

      /// en translation: Ok
      ///
      /// Locales: en
      public static func ok(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Ok", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Ok"
        }

        return NSLocalizedString("Ok", bundle: bundle, comment: "")
      }

      /// en translation: Postal Codes
      ///
      /// Locales: en
      public static func postalCodes(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("PostalCodes", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "PostalCodes"
        }

        return NSLocalizedString("PostalCodes", bundle: bundle, comment: "")
      }

      /// en translation: Saving postal codes
      ///
      /// Locales: en
      public static func savingLabel(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("SavingLabel", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "SavingLabel"
        }

        return NSLocalizedString("SavingLabel", bundle: bundle, comment: "")
      }

      /// en translation: WTTest for VIPER
      ///
      /// Locales: en
      public static func appTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("App Title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "App Title"
        }

        return NSLocalizedString("App Title", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      // There are no resources to validate
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

public struct _R {
  fileprivate init() {}
}
