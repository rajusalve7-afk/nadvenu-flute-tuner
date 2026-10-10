// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get productName => 'फ्लूट ट्यूनर प्रो';

  @override
  String get tagline => 'तुमच्या आत्म्याला सूर द्या';

  @override
  String get navTuner => 'ट्यूनर';

  @override
  String get navAnalysis => 'विश्लेषण';

  @override
  String get navSessions => 'सत्रे';

  @override
  String get navSettings => 'सेटिंग्ज';

  @override
  String get instrumentLabel => 'वाद्य';

  @override
  String get rootScale => 'मूल स्वर (सा)';

  @override
  String get inTune => 'सुरेल';

  @override
  String get flat => 'सपाट';

  @override
  String get sharp => 'तीव्र';

  @override
  String get cents => 'सेंट';

  @override
  String get confidence => 'विश्वास';

  @override
  String get a4Reference => 'A4 संदर्भ';

  @override
  String targetHz(String hz) {
    return 'लक्ष्य: $hz Hz';
  }

  @override
  String get selectInstrument => 'वाद्य निवडा';

  @override
  String get settingsTitle => 'सेटिंग्ज';

  @override
  String get sectionTuning => 'ट्यूनिंग';

  @override
  String get referenceFrequency => 'संदर्भ वारंवारता (A4)';

  @override
  String get tuningTolerance => 'ट्यूनिंग सहनशीलता';

  @override
  String get sensitivity => 'संवेदनशीलता';

  @override
  String get low => 'कमी';

  @override
  String get medium => 'मध्यम';

  @override
  String get high => 'जास्त';

  @override
  String get sectionPreferences => 'ॲप पसंती';

  @override
  String get darkTheme => 'गडद थीम';

  @override
  String get language => 'भाषा';

  @override
  String get showSwaras => 'भारतीय स्वर दाखवा';

  @override
  String get defaultInstrument => 'डीफॉल्ट वाद्य';

  @override
  String get sectionAbout => 'परिचय';

  @override
  String get privacyPolicy => 'गोपनीयता धोरण';

  @override
  String get rateUs => 'आम्हाला मोजा';

  @override
  String get appVersion => 'ॲप आवृत्ती';

  @override
  String get goPro => 'प्रो व्हा';

  @override
  String get nadvenuPro => 'नादवेणु प्रो';

  @override
  String get unlockPotential => 'पूर्ण क्षमता उघडा';

  @override
  String get benefitAdFreeTitle => 'जाहिरातींशिवाय';

  @override
  String get benefitAdFreeBody => 'सूर लावताना व्यत्यय नाही';

  @override
  String get benefitModesTitle => 'प्रगत ट्यूनिंग मोड';

  @override
  String get benefitModesBody => 'स्वतःचे सरगम आणि टेम्परामेंट';

  @override
  String get benefitAnalysisTitle => 'सविस्तर विश्लेषण';

  @override
  String get benefitAnalysisBody => 'हार्मोनिक्स आणि वारंवारता आलेख';

  @override
  String get benefitSessionsTitle => 'अमर्याद सत्रे जतन करा';

  @override
  String get benefitSessionsBody => 'सरावाचा इतिहास ठेवा';

  @override
  String get benefitProfilesTitle => 'स्वतःचे वाद्य प्रोफाइल';

  @override
  String get benefitProfilesBody => 'तुमची ट्यूनिंग तयार करून जतन करा';

  @override
  String get benefitSupportTitle => 'विकासासाठी साथ';

  @override
  String get benefitSupportBody => 'नादवेणु फ्लूट्स वाढवा';

  @override
  String get upgradeToPro => 'प्रो मध्ये श्रेणीवाढ';

  @override
  String get restorePurchase => 'खरेदी पुनर्स्थापित करा';

  @override
  String get proActive => 'प्रो पूर्वावलोकन सक्रिय';

  @override
  String get proPreviewNote =>
      'हे स्थानिक पूर्वावलोकन आहे. पैसे घेतले जात नाहीत.';

  @override
  String get upgradeDone => 'या उपकरणावर नादवेणु प्रो पूर्वावलोकन उघडले.';

  @override
  String get restoreDone => 'या उपकरणावर पूर्वावलोकन पुनर्स्थापित झाले.';

  @override
  String get analysisTitle => 'विश्लेषण';

  @override
  String get spectrum => 'वर्णपट';

  @override
  String get harmonics => 'हार्मोनिक्स';

  @override
  String get detectedFrequency => 'पकडलेली वारंवारता';

  @override
  String get tuningSessions => 'ट्यूनिंग सत्रे';

  @override
  String get selectLanguage => 'भाषा निवडा';

  @override
  String get referenceTitle => 'संदर्भ वारंवारता';

  @override
  String get standardFootnote =>
      'A4 (440 Hz) हा आधुनिक संगीतातील सर्वसामान्य संदर्भ आहे.';

  @override
  String get demoBanner => 'डेमो मोड — कृत्रिम स्वर';

  @override
  String get listening => 'ऐकत आहोत';

  @override
  String get micUnavailable =>
      'मायक्रोफोन उपलब्ध नाही. डेमो मोडमध्ये ट्यूनिंग सुरू आहे.';

  @override
  String sessionLocked(String note) {
    return '$note तुमच्या ट्यूनिंग सत्रांत जतन केला.';
  }

  @override
  String get outsideRange => 'या बासरीच्या नेहमीच्या पट्टीबाहेर';

  @override
  String get shareApp => 'ॲप शेअर करा';

  @override
  String get shareTitle => 'नादवेणु शेअर करा';

  @override
  String get shareMessage =>
      'नादवेणु फ्लूट ट्यूनर प्रो ने बासरी सूरत आणा — Tune Your Soul.';

  @override
  String get shareCopied => 'शेअर मजकूर कॉपी झाला.';

  @override
  String get copyText => 'मजकूर कॉपी करा';

  @override
  String get rateTitle => 'नादवेणु मोजा';

  @override
  String get rateBody =>
      'नादवेणु फ्लूट्स हा ट्यूनर स्थिर सा हवा असलेल्या वादकांसाठी बनवते. मोजमाप या उपकरणावर राहते आणि कुठे पाठवले जात नाही.';

  @override
  String get rateThanks => 'धन्यवाद. तुमचे मोजमाप या उपकरणावर जतन झाले.';

  @override
  String get submitRating => 'मोजमाप नोंदवा';

  @override
  String get privacyTitle => 'गोपनीयता धोरण';

  @override
  String get privacyBody =>
      'नादवेणु फ्लूट ट्यूनर प्रो नादवेणु फ्लूट्स ने बनवला आहे. ॲप खाते तयार करत नाही आणि तुमचे वाजवणे अपलोड करत नाही. सूर याच उपकरणावर मोजला जातो. सेटिंग्ज, भाषा आणि ट्यूनिंग सत्रे स्थानिक साठवणीत राहतात. मायक्रोफोन तेव्हाच चालतो जेव्हा तुम्ही ऐकणे निवडता, आणि डेमो मोड मायक्रोफोनशिवाय चालतो. या आवृत्तीतील प्रो श्रेणीवाढ पूर्वावलोकन आहे: ती या उपकरणावर एक चिन्ह उघडते आणि पैसे किंवा स्टोअरशी संपर्क करत नाही.';

  @override
  String todayTime(String time) {
    return 'आज, $time';
  }

  @override
  String get noSessions => 'अजून सत्रे नाहीत';

  @override
  String get noSessionsBody =>
      'गोळी सुरेल म्हणेपर्यंत स्थिर स्वर धरा. नादवेणु तो वाचन येथे जतन करतो.';

  @override
  String get tuningMode => 'ट्यूनिंग मोड';

  @override
  String get equalTemperament => 'सम स्वर विभागणी';

  @override
  String get justIntonation => 'शुद्ध स्वर';

  @override
  String get proRequired => 'शुद्ध स्वर नादवेणु प्रो पूर्वावलोकनाचा भाग आहे.';

  @override
  String get openMenu => 'मेनू उघडा';

  @override
  String get close => 'बंद करा';

  @override
  String get komal => 'कोमल';

  @override
  String get tivra => 'तीव्र';

  @override
  String get swaraSa => 'सा';

  @override
  String get swaraRe => 'रे';

  @override
  String get swaraGa => 'ग';

  @override
  String get swaraMa => 'म';

  @override
  String get swaraPa => 'प';

  @override
  String get swaraDha => 'ध';

  @override
  String get swaraNi => 'नि';

  @override
  String get instrumentBansuri => 'भारतीय बांसुरी';

  @override
  String get instrumentBansuriDesc => 'पारंपरिक भारतीय बांबू बासरी';

  @override
  String get instrumentConcert => 'पाश्चिमात्य कॉन्सर्ट फ्लूट';

  @override
  String get instrumentConcertDesc => 'मानक कॉन्सर्ट फ्लूट';

  @override
  String get instrumentNative => 'नेटिव्ह अमेरिकन फ्लूट';

  @override
  String get instrumentNativeDesc => 'मूळ अमेरिकन शैली';

  @override
  String get instrumentQuena => 'केना';

  @override
  String get instrumentQuenaDesc => 'अँडियन फ्लूट';

  @override
  String get instrumentRecorder => 'रेकॉर्डर';

  @override
  String get instrumentRecorderDesc => 'सोप्रानो / आल्टो रेकॉर्डर';

  @override
  String get instrumentChromatic => 'सार्वत्रिक क्रोमॅटिक';

  @override
  String get instrumentChromaticDesc => 'सर्व स्वर C–B';

  @override
  String rangeSpan(String low, String high) {
    return '$low – $high';
  }

  @override
  String toleranceValue(int cents) {
    return '±$cents सेंट';
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
  String get decrease => 'कमी करा';

  @override
  String get increase => 'वाढवा';

  @override
  String get waitingForTone => 'स्वराची वाट';

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
