// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get productName => 'Flute Tuner Pro';

  @override
  String get tagline => 'Tune Your Soul';

  @override
  String get navTuner => 'Tuner';

  @override
  String get navAnalysis => 'Analysis';

  @override
  String get navSessions => 'Sessions';

  @override
  String get navSettings => 'Settings';

  @override
  String get instrumentLabel => 'Instrument';

  @override
  String get rootScale => 'Root Scale (Sa)';

  @override
  String get inTune => 'In Tune';

  @override
  String get flat => 'Flat';

  @override
  String get sharp => 'Sharp';

  @override
  String get cents => 'Cents';

  @override
  String get confidence => 'Confidence';

  @override
  String get a4Reference => 'A4 Reference';

  @override
  String targetHz(String hz) {
    return 'Target: $hz Hz';
  }

  @override
  String get selectInstrument => 'Select Instrument';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get sectionTuning => 'Tuning';

  @override
  String get referenceFrequency => 'Reference Frequency (A4)';

  @override
  String get tuningTolerance => 'Tuning Tolerance';

  @override
  String get sensitivity => 'Sensitivity';

  @override
  String get low => 'Low';

  @override
  String get medium => 'Medium';

  @override
  String get high => 'High';

  @override
  String get sectionPreferences => 'App Preferences';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get language => 'Language';

  @override
  String get showSwaras => 'Show Indian Swaras';

  @override
  String get defaultInstrument => 'Default Instrument';

  @override
  String get sectionAbout => 'About';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get rateUs => 'Rate Us';

  @override
  String get appVersion => 'App Version';

  @override
  String get goPro => 'Go Pro';

  @override
  String get nadvenuPro => 'Nadvenu Pro';

  @override
  String get unlockPotential => 'Unlock the Full Potential';

  @override
  String get benefitAdFreeTitle => 'Ad-Free Experience';

  @override
  String get benefitAdFreeBody => 'No interruptions while tuning';

  @override
  String get benefitModesTitle => 'Advanced Tuning Modes';

  @override
  String get benefitModesBody => 'Custom scales & temperaments';

  @override
  String get benefitAnalysisTitle => 'Detailed Analysis';

  @override
  String get benefitAnalysisBody => 'Harmonics, frequency graphs';

  @override
  String get benefitSessionsTitle => 'Save Unlimited Sessions';

  @override
  String get benefitSessionsBody => 'Keep your practice history';

  @override
  String get benefitProfilesTitle => 'Custom Instrument Profiles';

  @override
  String get benefitProfilesBody => 'Create and save your own tunings';

  @override
  String get benefitSupportTitle => 'Support Development';

  @override
  String get benefitSupportBody => 'Help us grow Nadvenu Flutes';

  @override
  String get upgradeToPro => 'Upgrade to Pro';

  @override
  String get restorePurchase => 'Restore Purchase';

  @override
  String get proActive => 'Pro Preview Active';

  @override
  String get proPreviewNote => 'This is a local preview. No payment is taken.';

  @override
  String get upgradeDone => 'Nadvenu Pro preview is unlocked on this device.';

  @override
  String get restoreDone => 'Preview purchases restored on this device.';

  @override
  String get analysisTitle => 'Analysis';

  @override
  String get spectrum => 'Spectrum';

  @override
  String get harmonics => 'Harmonics';

  @override
  String get detectedFrequency => 'Detected Frequency';

  @override
  String get tuningSessions => 'Tuning Sessions';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get referenceTitle => 'Reference Frequency';

  @override
  String get standardFootnote =>
      'A4 (440 Hz) is the standard reference used in most modern music.';

  @override
  String get demoBanner => 'Demo mode — simulated pitch';

  @override
  String get listening => 'Listening';

  @override
  String get micUnavailable =>
      'Microphone unavailable. Staying in demo mode so you can still tune.';

  @override
  String sessionLocked(String note) {
    return 'Saved $note to your tuning sessions.';
  }

  @override
  String get outsideRange => 'Outside this flute\'s usual range';

  @override
  String get shareApp => 'Share App';

  @override
  String get shareTitle => 'Share Nadvenu';

  @override
  String get shareMessage =>
      'Tune your flute with Nadvenu Flute Tuner Pro — Tune Your Soul. Sargam, cents, and a reference pitch you choose.';

  @override
  String get shareCopied => 'Share text copied.';

  @override
  String get copyText => 'Copy text';

  @override
  String get rateTitle => 'Rate Nadvenu';

  @override
  String get rateBody =>
      'Nadvenu Flutes makes this tuner for players who want a steady Sa. A rating stays on this device and is not sent anywhere.';

  @override
  String get rateThanks => 'Thank you. Your rating is saved on this device.';

  @override
  String get submitRating => 'Submit rating';

  @override
  String get privacyTitle => 'Privacy Policy';

  @override
  String get privacyBody =>
      'Nadvenu Flute Tuner Pro is made by Nadvenu Flutes. The app does not create an account and does not upload your playing. Pitch is measured on this device. Settings, language, and tuning sessions stay in local storage. Microphone access is used only while you choose to listen, and demo mode works with no microphone at all. The Pro upgrade in this version is a preview: it unlocks a flag on this device and does not charge a payment or contact a store.';

  @override
  String todayTime(String time) {
    return 'Today, $time';
  }

  @override
  String get noSessions => 'No sessions yet';

  @override
  String get noSessionsBody =>
      'Hold a steady note until the pill says In Tune. Nadvenu saves that reading here.';

  @override
  String get tuningMode => 'Tuning Mode';

  @override
  String get equalTemperament => 'Equal temperament';

  @override
  String get justIntonation => 'Just intonation';

  @override
  String get proRequired =>
      'Just intonation is part of the Nadvenu Pro preview.';

  @override
  String get openMenu => 'Open menu';

  @override
  String get close => 'Close';

  @override
  String get komal => 'komal';

  @override
  String get tivra => 'tivra';

  @override
  String get swaraSa => 'Sa';

  @override
  String get swaraRe => 'Re';

  @override
  String get swaraGa => 'Ga';

  @override
  String get swaraMa => 'Ma';

  @override
  String get swaraPa => 'Pa';

  @override
  String get swaraDha => 'Dha';

  @override
  String get swaraNi => 'Ni';

  @override
  String get instrumentBansuri => 'Indian Bansuri';

  @override
  String get instrumentBansuriDesc => 'Traditional Indian Bamboo Flute';

  @override
  String get instrumentConcert => 'Western Concert Flute';

  @override
  String get instrumentConcertDesc => 'Standard Concert Flute';

  @override
  String get instrumentNative => 'Native American Flute';

  @override
  String get instrumentNativeDesc => 'Native American Style';

  @override
  String get instrumentQuena => 'Quena';

  @override
  String get instrumentQuenaDesc => 'Andean Flute';

  @override
  String get instrumentRecorder => 'Recorder';

  @override
  String get instrumentRecorderDesc => 'Soprano / Alto Recorder';

  @override
  String get instrumentChromatic => 'Universal Chromatic';

  @override
  String get instrumentChromaticDesc => 'All Notes C–B';

  @override
  String rangeSpan(String low, String high) {
    return '$low – $high';
  }

  @override
  String toleranceValue(int cents) {
    return '±$cents cents';
  }

  @override
  String hzValue(String hz) {
    return '$hz Hz';
  }

  @override
  String percentValue(int value) {
    return '$value%';
  }

  @override
  String get decrease => 'Decrease';

  @override
  String get increase => 'Increase';

  @override
  String get waitingForTone => 'Waiting for a tone';

  @override
  String get versionLabel => 'v1.0.0';

  @override
  String get a4Symbol => 'A4';

  @override
  String get languageNameEn => 'English';

  @override
  String get languageNameHi => 'हिन्दी';

  @override
  String get languageNameMr => 'मराठी';

  @override
  String get languageNameGu => 'ગુજરાતી';

  @override
  String get languageNameBn => 'বাংলা';

  @override
  String get languageNameTa => 'தமிழ்';

  @override
  String get languageNameTe => 'తెలుగు';
}
