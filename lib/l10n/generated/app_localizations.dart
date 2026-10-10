import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('bn'),
    Locale('en'),
    Locale('gu'),
    Locale('hi'),
    Locale('mr'),
    Locale('ta'),
    Locale('te'),
  ];

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Flute Tuner Pro'**
  String get productName;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Tune Your Soul'**
  String get tagline;

  /// No description provided for @navTuner.
  ///
  /// In en, this message translates to:
  /// **'Tuner'**
  String get navTuner;

  /// No description provided for @navAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get navAnalysis;

  /// No description provided for @navSessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get navSessions;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @instrumentLabel.
  ///
  /// In en, this message translates to:
  /// **'Instrument'**
  String get instrumentLabel;

  /// No description provided for @rootScale.
  ///
  /// In en, this message translates to:
  /// **'Root Scale (Sa)'**
  String get rootScale;

  /// No description provided for @inTune.
  ///
  /// In en, this message translates to:
  /// **'In Tune'**
  String get inTune;

  /// No description provided for @flat.
  ///
  /// In en, this message translates to:
  /// **'Flat'**
  String get flat;

  /// No description provided for @sharp.
  ///
  /// In en, this message translates to:
  /// **'Sharp'**
  String get sharp;

  /// No description provided for @cents.
  ///
  /// In en, this message translates to:
  /// **'Cents'**
  String get cents;

  /// No description provided for @confidence.
  ///
  /// In en, this message translates to:
  /// **'Confidence'**
  String get confidence;

  /// No description provided for @a4Reference.
  ///
  /// In en, this message translates to:
  /// **'A4 Reference'**
  String get a4Reference;

  /// No description provided for @targetHz.
  ///
  /// In en, this message translates to:
  /// **'Target: {hz} Hz'**
  String targetHz(String hz);

  /// No description provided for @selectInstrument.
  ///
  /// In en, this message translates to:
  /// **'Select Instrument'**
  String get selectInstrument;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @sectionTuning.
  ///
  /// In en, this message translates to:
  /// **'Tuning'**
  String get sectionTuning;

  /// No description provided for @referenceFrequency.
  ///
  /// In en, this message translates to:
  /// **'Reference Frequency (A4)'**
  String get referenceFrequency;

  /// No description provided for @tuningTolerance.
  ///
  /// In en, this message translates to:
  /// **'Tuning Tolerance'**
  String get tuningTolerance;

  /// No description provided for @sensitivity.
  ///
  /// In en, this message translates to:
  /// **'Sensitivity'**
  String get sensitivity;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @sectionPreferences.
  ///
  /// In en, this message translates to:
  /// **'App Preferences'**
  String get sectionPreferences;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @showSwaras.
  ///
  /// In en, this message translates to:
  /// **'Show Indian Swaras'**
  String get showSwaras;

  /// No description provided for @defaultInstrument.
  ///
  /// In en, this message translates to:
  /// **'Default Instrument'**
  String get defaultInstrument;

  /// No description provided for @sectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get sectionAbout;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @rateUs.
  ///
  /// In en, this message translates to:
  /// **'Rate Us'**
  String get rateUs;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// No description provided for @goPro.
  ///
  /// In en, this message translates to:
  /// **'Go Pro'**
  String get goPro;

  /// No description provided for @nadvenuPro.
  ///
  /// In en, this message translates to:
  /// **'Nadvenu Pro'**
  String get nadvenuPro;

  /// No description provided for @unlockPotential.
  ///
  /// In en, this message translates to:
  /// **'Unlock the Full Potential'**
  String get unlockPotential;

  /// No description provided for @benefitAdFreeTitle.
  ///
  /// In en, this message translates to:
  /// **'Ad-Free Experience'**
  String get benefitAdFreeTitle;

  /// No description provided for @benefitAdFreeBody.
  ///
  /// In en, this message translates to:
  /// **'No interruptions while tuning'**
  String get benefitAdFreeBody;

  /// No description provided for @benefitModesTitle.
  ///
  /// In en, this message translates to:
  /// **'Advanced Tuning Modes'**
  String get benefitModesTitle;

  /// No description provided for @benefitModesBody.
  ///
  /// In en, this message translates to:
  /// **'Custom scales & temperaments'**
  String get benefitModesBody;

  /// No description provided for @benefitAnalysisTitle.
  ///
  /// In en, this message translates to:
  /// **'Detailed Analysis'**
  String get benefitAnalysisTitle;

  /// No description provided for @benefitAnalysisBody.
  ///
  /// In en, this message translates to:
  /// **'Harmonics, frequency graphs'**
  String get benefitAnalysisBody;

  /// No description provided for @benefitSessionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Save Unlimited Sessions'**
  String get benefitSessionsTitle;

  /// No description provided for @benefitSessionsBody.
  ///
  /// In en, this message translates to:
  /// **'Keep your practice history'**
  String get benefitSessionsBody;

  /// No description provided for @benefitProfilesTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom Instrument Profiles'**
  String get benefitProfilesTitle;

  /// No description provided for @benefitProfilesBody.
  ///
  /// In en, this message translates to:
  /// **'Create and save your own tunings'**
  String get benefitProfilesBody;

  /// No description provided for @benefitSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Development'**
  String get benefitSupportTitle;

  /// No description provided for @benefitSupportBody.
  ///
  /// In en, this message translates to:
  /// **'Help us grow Nadvenu Flutes'**
  String get benefitSupportBody;

  /// No description provided for @upgradeToPro.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get upgradeToPro;

  /// No description provided for @restorePurchase.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchase'**
  String get restorePurchase;

  /// No description provided for @proActive.
  ///
  /// In en, this message translates to:
  /// **'Pro Preview Active'**
  String get proActive;

  /// No description provided for @proPreviewNote.
  ///
  /// In en, this message translates to:
  /// **'This is a local preview. No payment is taken.'**
  String get proPreviewNote;

  /// No description provided for @upgradeDone.
  ///
  /// In en, this message translates to:
  /// **'Nadvenu Pro preview is unlocked on this device.'**
  String get upgradeDone;

  /// No description provided for @restoreDone.
  ///
  /// In en, this message translates to:
  /// **'Preview purchases restored on this device.'**
  String get restoreDone;

  /// No description provided for @analysisTitle.
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get analysisTitle;

  /// No description provided for @spectrum.
  ///
  /// In en, this message translates to:
  /// **'Spectrum'**
  String get spectrum;

  /// No description provided for @harmonics.
  ///
  /// In en, this message translates to:
  /// **'Harmonics'**
  String get harmonics;

  /// No description provided for @detectedFrequency.
  ///
  /// In en, this message translates to:
  /// **'Detected Frequency'**
  String get detectedFrequency;

  /// No description provided for @tuningSessions.
  ///
  /// In en, this message translates to:
  /// **'Tuning Sessions'**
  String get tuningSessions;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @referenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Reference Frequency'**
  String get referenceTitle;

  /// No description provided for @standardFootnote.
  ///
  /// In en, this message translates to:
  /// **'A4 (440 Hz) is the standard reference used in most modern music.'**
  String get standardFootnote;

  /// No description provided for @demoBanner.
  ///
  /// In en, this message translates to:
  /// **'Demo mode — simulated pitch'**
  String get demoBanner;

  /// No description provided for @listening.
  ///
  /// In en, this message translates to:
  /// **'Listening'**
  String get listening;

  /// No description provided for @micUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Microphone unavailable. Staying in demo mode so you can still tune.'**
  String get micUnavailable;

  /// No description provided for @sessionLocked.
  ///
  /// In en, this message translates to:
  /// **'Saved {note} to your tuning sessions.'**
  String sessionLocked(String note);

  /// No description provided for @outsideRange.
  ///
  /// In en, this message translates to:
  /// **'Outside this flute\'s usual range'**
  String get outsideRange;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// No description provided for @shareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share Nadvenu'**
  String get shareTitle;

  /// No description provided for @shareMessage.
  ///
  /// In en, this message translates to:
  /// **'Tune your flute with Nadvenu Flute Tuner Pro — Tune Your Soul. Sargam, cents, and a reference pitch you choose.'**
  String get shareMessage;

  /// No description provided for @shareCopied.
  ///
  /// In en, this message translates to:
  /// **'Share text copied.'**
  String get shareCopied;

  /// No description provided for @copyText.
  ///
  /// In en, this message translates to:
  /// **'Copy text'**
  String get copyText;

  /// No description provided for @rateTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate Nadvenu'**
  String get rateTitle;

  /// No description provided for @rateBody.
  ///
  /// In en, this message translates to:
  /// **'Nadvenu Flutes makes this tuner for players who want a steady Sa. A rating stays on this device and is not sent anywhere.'**
  String get rateBody;

  /// No description provided for @rateThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you. Your rating is saved on this device.'**
  String get rateThanks;

  /// No description provided for @submitRating.
  ///
  /// In en, this message translates to:
  /// **'Submit rating'**
  String get submitRating;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyTitle;

  /// No description provided for @privacyBody.
  ///
  /// In en, this message translates to:
  /// **'Nadvenu Flute Tuner Pro is made by Nadvenu Flutes. The app does not create an account and does not upload your playing. Pitch is measured on this device. Settings, language, and tuning sessions stay in local storage. Microphone access is used only while you choose to listen, and demo mode works with no microphone at all. The Pro upgrade in this version is a preview: it unlocks a flag on this device and does not charge a payment or contact a store.'**
  String get privacyBody;

  /// No description provided for @todayTime.
  ///
  /// In en, this message translates to:
  /// **'Today, {time}'**
  String todayTime(String time);

  /// No description provided for @noSessions.
  ///
  /// In en, this message translates to:
  /// **'No sessions yet'**
  String get noSessions;

  /// No description provided for @noSessionsBody.
  ///
  /// In en, this message translates to:
  /// **'Hold a steady note until the pill says In Tune. Nadvenu saves that reading here.'**
  String get noSessionsBody;

  /// No description provided for @tuningMode.
  ///
  /// In en, this message translates to:
  /// **'Tuning Mode'**
  String get tuningMode;

  /// No description provided for @equalTemperament.
  ///
  /// In en, this message translates to:
  /// **'Equal temperament'**
  String get equalTemperament;

  /// No description provided for @justIntonation.
  ///
  /// In en, this message translates to:
  /// **'Just intonation'**
  String get justIntonation;

  /// No description provided for @proRequired.
  ///
  /// In en, this message translates to:
  /// **'Just intonation is part of the Nadvenu Pro preview.'**
  String get proRequired;

  /// No description provided for @openMenu.
  ///
  /// In en, this message translates to:
  /// **'Open menu'**
  String get openMenu;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @komal.
  ///
  /// In en, this message translates to:
  /// **'komal'**
  String get komal;

  /// No description provided for @tivra.
  ///
  /// In en, this message translates to:
  /// **'tivra'**
  String get tivra;

  /// No description provided for @swaraSa.
  ///
  /// In en, this message translates to:
  /// **'Sa'**
  String get swaraSa;

  /// No description provided for @swaraRe.
  ///
  /// In en, this message translates to:
  /// **'Re'**
  String get swaraRe;

  /// No description provided for @swaraGa.
  ///
  /// In en, this message translates to:
  /// **'Ga'**
  String get swaraGa;

  /// No description provided for @swaraMa.
  ///
  /// In en, this message translates to:
  /// **'Ma'**
  String get swaraMa;

  /// No description provided for @swaraPa.
  ///
  /// In en, this message translates to:
  /// **'Pa'**
  String get swaraPa;

  /// No description provided for @swaraDha.
  ///
  /// In en, this message translates to:
  /// **'Dha'**
  String get swaraDha;

  /// No description provided for @swaraNi.
  ///
  /// In en, this message translates to:
  /// **'Ni'**
  String get swaraNi;

  /// No description provided for @instrumentBansuri.
  ///
  /// In en, this message translates to:
  /// **'Indian Bansuri'**
  String get instrumentBansuri;

  /// No description provided for @instrumentBansuriDesc.
  ///
  /// In en, this message translates to:
  /// **'Traditional Indian Bamboo Flute'**
  String get instrumentBansuriDesc;

  /// No description provided for @instrumentConcert.
  ///
  /// In en, this message translates to:
  /// **'Western Concert Flute'**
  String get instrumentConcert;

  /// No description provided for @instrumentConcertDesc.
  ///
  /// In en, this message translates to:
  /// **'Standard Concert Flute'**
  String get instrumentConcertDesc;

  /// No description provided for @instrumentNative.
  ///
  /// In en, this message translates to:
  /// **'Native American Flute'**
  String get instrumentNative;

  /// No description provided for @instrumentNativeDesc.
  ///
  /// In en, this message translates to:
  /// **'Native American Style'**
  String get instrumentNativeDesc;

  /// No description provided for @instrumentQuena.
  ///
  /// In en, this message translates to:
  /// **'Quena'**
  String get instrumentQuena;

  /// No description provided for @instrumentQuenaDesc.
  ///
  /// In en, this message translates to:
  /// **'Andean Flute'**
  String get instrumentQuenaDesc;

  /// No description provided for @instrumentRecorder.
  ///
  /// In en, this message translates to:
  /// **'Recorder'**
  String get instrumentRecorder;

  /// No description provided for @instrumentRecorderDesc.
  ///
  /// In en, this message translates to:
  /// **'Soprano / Alto Recorder'**
  String get instrumentRecorderDesc;

  /// No description provided for @instrumentChromatic.
  ///
  /// In en, this message translates to:
  /// **'Universal Chromatic'**
  String get instrumentChromatic;

  /// No description provided for @instrumentChromaticDesc.
  ///
  /// In en, this message translates to:
  /// **'All Notes C–B'**
  String get instrumentChromaticDesc;

  /// No description provided for @rangeSpan.
  ///
  /// In en, this message translates to:
  /// **'{low} – {high}'**
  String rangeSpan(String low, String high);

  /// No description provided for @toleranceValue.
  ///
  /// In en, this message translates to:
  /// **'±{cents} cents'**
  String toleranceValue(int cents);

  /// No description provided for @hzValue.
  ///
  /// In en, this message translates to:
  /// **'{hz} Hz'**
  String hzValue(String hz);

  /// No description provided for @percentValue.
  ///
  /// In en, this message translates to:
  /// **'{value}%'**
  String percentValue(int value);

  /// No description provided for @decrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get decrease;

  /// No description provided for @increase.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get increase;

  /// No description provided for @waitingForTone.
  ///
  /// In en, this message translates to:
  /// **'Waiting for a tone'**
  String get waitingForTone;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'v1.0.0'**
  String get versionLabel;

  /// No description provided for @a4Symbol.
  ///
  /// In en, this message translates to:
  /// **'A4'**
  String get a4Symbol;

  /// No description provided for @languageNameEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageNameEn;

  /// No description provided for @languageNameHi.
  ///
  /// In en, this message translates to:
  /// **'हिन्दी'**
  String get languageNameHi;

  /// No description provided for @languageNameMr.
  ///
  /// In en, this message translates to:
  /// **'मराठी'**
  String get languageNameMr;

  /// No description provided for @languageNameGu.
  ///
  /// In en, this message translates to:
  /// **'ગુજરાતી'**
  String get languageNameGu;

  /// No description provided for @languageNameBn.
  ///
  /// In en, this message translates to:
  /// **'বাংলা'**
  String get languageNameBn;

  /// No description provided for @languageNameTa.
  ///
  /// In en, this message translates to:
  /// **'தமிழ்'**
  String get languageNameTa;

  /// No description provided for @languageNameTe.
  ///
  /// In en, this message translates to:
  /// **'తెలుగు'**
  String get languageNameTe;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'bn',
    'en',
    'gu',
    'hi',
    'mr',
    'ta',
    'te',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
    case 'gu':
      return AppLocalizationsGu();
    case 'hi':
      return AppLocalizationsHi();
    case 'mr':
      return AppLocalizationsMr();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
