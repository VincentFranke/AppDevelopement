import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @code0.
  ///
  /// In en, this message translates to:
  /// **'Clear sky'**
  String get code0;

  /// No description provided for @code1.
  ///
  /// In en, this message translates to:
  /// **'Mainly clear'**
  String get code1;

  /// No description provided for @code2.
  ///
  /// In en, this message translates to:
  /// **'Partly cloudy'**
  String get code2;

  /// No description provided for @code3.
  ///
  /// In en, this message translates to:
  /// **'Overcast'**
  String get code3;

  /// No description provided for @code45.
  ///
  /// In en, this message translates to:
  /// **'Fog'**
  String get code45;

  /// No description provided for @code48.
  ///
  /// In en, this message translates to:
  /// **'Depositing rime fog'**
  String get code48;

  /// No description provided for @code51.
  ///
  /// In en, this message translates to:
  /// **'Light drizzle'**
  String get code51;

  /// No description provided for @code53.
  ///
  /// In en, this message translates to:
  /// **'Moderate drizzle'**
  String get code53;

  /// No description provided for @code55.
  ///
  /// In en, this message translates to:
  /// **'Dense drizzle'**
  String get code55;

  /// No description provided for @code56.
  ///
  /// In en, this message translates to:
  /// **'Light freezing drizzle'**
  String get code56;

  /// No description provided for @code57.
  ///
  /// In en, this message translates to:
  /// **'Dense freezing drizzle'**
  String get code57;

  /// No description provided for @code61.
  ///
  /// In en, this message translates to:
  /// **'Slight rain'**
  String get code61;

  /// No description provided for @code63.
  ///
  /// In en, this message translates to:
  /// **'Moderate rain'**
  String get code63;

  /// No description provided for @code65.
  ///
  /// In en, this message translates to:
  /// **'Heavy Rain'**
  String get code65;

  /// No description provided for @code66.
  ///
  /// In en, this message translates to:
  /// **'Light freezing rain'**
  String get code66;

  /// No description provided for @code67.
  ///
  /// In en, this message translates to:
  /// **'Heavy freezing rain'**
  String get code67;

  /// No description provided for @code71.
  ///
  /// In en, this message translates to:
  /// **'Slight snow fall'**
  String get code71;

  /// No description provided for @code73.
  ///
  /// In en, this message translates to:
  /// **'Moderate snow fall'**
  String get code73;

  /// No description provided for @code75.
  ///
  /// In en, this message translates to:
  /// **'Heavy snow fall'**
  String get code75;

  /// No description provided for @code77.
  ///
  /// In en, this message translates to:
  /// **'Snow grains'**
  String get code77;

  /// No description provided for @code80.
  ///
  /// In en, this message translates to:
  /// **'Slight rain showers'**
  String get code80;

  /// No description provided for @code81.
  ///
  /// In en, this message translates to:
  /// **'Moderate rain showers'**
  String get code81;

  /// No description provided for @code82.
  ///
  /// In en, this message translates to:
  /// **'Voilent rain showers'**
  String get code82;

  /// No description provided for @code85.
  ///
  /// In en, this message translates to:
  /// **'Slight snow showers'**
  String get code85;

  /// No description provided for @code86.
  ///
  /// In en, this message translates to:
  /// **'Heavy snow showers'**
  String get code86;

  /// No description provided for @code95.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorm'**
  String get code95;

  /// No description provided for @code96.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorm with slight hail'**
  String get code96;

  /// No description provided for @code99.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorm with heavy hail'**
  String get code99;

  /// No description provided for @codeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown weather tread carefully!'**
  String get codeUnknown;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @dayForecast.
  ///
  /// In en, this message translates to:
  /// **'Day Forecast'**
  String get dayForecast;

  /// No description provided for @dayView.
  ///
  /// In en, this message translates to:
  /// **'Day View'**
  String get dayView;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorInvalidState.
  ///
  /// In en, this message translates to:
  /// **'Error invalid state'**
  String get errorInvalidState;

  /// No description provided for @federalState.
  ///
  /// In en, this message translates to:
  /// **'Federal State'**
  String get federalState;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @selectCity.
  ///
  /// In en, this message translates to:
  /// **'Select City'**
  String get selectCity;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'sunday'**
  String get sunday;

  /// No description provided for @sunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunrise;

  /// No description provided for @sunset.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get sunset;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Weather App'**
  String get title;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'wednesday'**
  String get wednesday;

  /// No description provided for @weekView.
  ///
  /// In en, this message translates to:
  /// **'Week View'**
  String get weekView;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
