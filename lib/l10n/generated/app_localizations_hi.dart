// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get productName => 'फ्लूट ट्यूनर प्रो';

  @override
  String get tagline => 'अपनी आत्मा को सुर में लाएँ';

  @override
  String get navTuner => 'ट्यूनर';

  @override
  String get navAnalysis => 'विश्लेषण';

  @override
  String get navSessions => 'सत्र';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get instrumentLabel => 'वाद्य';

  @override
  String get rootScale => 'मूल स्वर (सा)';

  @override
  String get inTune => 'सुर में';

  @override
  String get flat => 'नीचे';

  @override
  String get sharp => 'ऊपर';

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
  String get selectInstrument => 'वाद्य चुनें';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get sectionTuning => 'ट्यूनिंग';

  @override
  String get referenceFrequency => 'संदर्भ आवृत्ति (A4)';

  @override
  String get tuningTolerance => 'ट्यूनिंग सहनशीलता';

  @override
  String get sensitivity => 'संवेदनशीलता';

  @override
  String get low => 'कम';

  @override
  String get medium => 'मध्यम';

  @override
  String get high => 'अधिक';

  @override
  String get sectionPreferences => 'ऐप प्राथमिकताएँ';

  @override
  String get darkTheme => 'गहरी थीम';

  @override
  String get language => 'भाषा';

  @override
  String get showSwaras => 'भारतीय स्वर दिखाएँ';

  @override
  String get defaultInstrument => 'डिफ़ॉल्ट वाद्य';

  @override
  String get sectionAbout => 'परिचय';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get rateUs => 'हमें आँकें';

  @override
  String get appVersion => 'ऐप संस्करण';

  @override
  String get goPro => 'प्रो बनें';

  @override
  String get nadvenuPro => 'नादवेणु प्रो';

  @override
  String get unlockPotential => 'पूरी क्षमता खोलें';

  @override
  String get benefitAdFreeTitle => 'बिना विज्ञापन';

  @override
  String get benefitAdFreeBody => 'ट्यूनिंग के दौरान कोई रुकावट नहीं';

  @override
  String get benefitModesTitle => 'उन्नत ट्यूनिंग मोड';

  @override
  String get benefitModesBody => 'अपनी सरगम और टेम्परामेंट';

  @override
  String get benefitAnalysisTitle => 'विस्तृत विश्लेषण';

  @override
  String get benefitAnalysisBody => 'हार्मोनिक्स और आवृत्ति ग्राफ';

  @override
  String get benefitSessionsTitle => 'असीमित सत्र सहेजें';

  @override
  String get benefitSessionsBody => 'अभ्यास का इतिहास रखें';

  @override
  String get benefitProfilesTitle => 'अपने वाद्य प्रोफ़ाइल';

  @override
  String get benefitProfilesBody => 'अपनी ट्यूनिंग बनाएँ और सहेजें';

  @override
  String get benefitSupportTitle => 'विकास में साथ दें';

  @override
  String get benefitSupportBody => 'नादवेणु फ्लूट्स को आगे बढ़ाएँ';

  @override
  String get upgradeToPro => 'प्रो में अपग्रेड करें';

  @override
  String get restorePurchase => 'खरीदारी बहाल करें';

  @override
  String get proActive => 'प्रो पूर्वावलोकन सक्रिय';

  @override
  String get proPreviewNote =>
      'यह स्थानीय पूर्वावलोकन है। कोई भुगतान नहीं लिया जाता।';

  @override
  String get upgradeDone => 'इस डिवाइस पर नादवेणु प्रो पूर्वावलोकन खुल गया।';

  @override
  String get restoreDone => 'इस डिवाइस पर पूर्वावलोकन बहाल हो गया।';

  @override
  String get analysisTitle => 'विश्लेषण';

  @override
  String get spectrum => 'स्पेक्ट्रम';

  @override
  String get harmonics => 'हार्मोनिक्स';

  @override
  String get detectedFrequency => 'पकड़ी गई आवृत्ति';

  @override
  String get tuningSessions => 'ट्यूनिंग सत्र';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get referenceTitle => 'संदर्भ आवृत्ति';

  @override
  String get standardFootnote =>
      'A4 (440 Hz) आधुनिक संगीत में प्रचलित मानक संदर्भ है।';

  @override
  String get demoBanner => 'डेमो मोड — नकली स्वर';

  @override
  String get listening => 'सुन रहे हैं';

  @override
  String get micUnavailable =>
      'माइक्रोफ़ोन उपलब्ध नहीं। डेमो मोड में ट्यूनिंग जारी है।';

  @override
  String sessionLocked(String note) {
    return '$note आपके ट्यूनिंग सत्रों में सहेजा गया।';
  }

  @override
  String get outsideRange => 'इस बाँसुरी की सामान्य सीमा से बाहर';

  @override
  String get shareApp => 'ऐप साझा करें';

  @override
  String get shareTitle => 'नादवेणु साझा करें';

  @override
  String get shareMessage =>
      'नादवेणु फ्लूट ट्यूनर प्रो से अपनी बाँसुरी सुर में लाएँ — Tune Your Soul।';

  @override
  String get shareCopied => 'साझा करने वाला पाठ कॉपी हो गया।';

  @override
  String get copyText => 'पाठ कॉपी करें';

  @override
  String get rateTitle => 'नादवेणु को आँकें';

  @override
  String get rateBody =>
      'नादवेणु फ्लूट्स यह ट्यूनर उन वादकों के लिए बनाता है जो स्थिर सा चाहते हैं। आँकना इस डिवाइस पर रहता है और कहीं भेजा नहीं जाता।';

  @override
  String get rateThanks => 'धन्यवाद। आपका आँकना इस डिवाइस पर सहेजा गया।';

  @override
  String get submitRating => 'आँकना भेजें';

  @override
  String get privacyTitle => 'गोपनीयता नीति';

  @override
  String get privacyBody =>
      'नादवेणु फ्लूट ट्यूनर प्रो नादवेणु फ्लूट्स की रचना है। ऐप खाता नहीं बनाता और आपकी बजत अपलोड नहीं करता। सुर इसी डिवाइस पर नापा जाता है। सेटिंग, भाषा और ट्यूनिंग सत्र स्थानीय संग्रह में रहते हैं। माइक्रोफ़ोन केवल तब चलता है जब आप सुनना चुनते हैं, और डेमो मोड बिना माइक्रोफ़ोन के काम करता है। इस संस्करण में प्रो अपग्रेड एक पूर्वावलोकन है: यह इसी डिवाइस पर एक चिह्न खोलता है और भुगतान या स्टोर से संपर्क नहीं करता।';

  @override
  String todayTime(String time) {
    return 'आज, $time';
  }

  @override
  String get noSessions => 'अभी कोई सत्र नहीं';

  @override
  String get noSessionsBody =>
      'जब तक गोली सुर में न कहे, एक स्थिर स्वर रखें। नादवेणु वह पाठ यहाँ सहेजता है।';

  @override
  String get tuningMode => 'ट्यूनिंग मोड';

  @override
  String get equalTemperament => 'सम स्वर विभाजन';

  @override
  String get justIntonation => 'शुद्ध स्वर';

  @override
  String get proRequired => 'शुद्ध स्वर नादवेणु प्रो पूर्वावलोकन का हिस्सा है।';

  @override
  String get openMenu => 'मेनू खोलें';

  @override
  String get close => 'बंद करें';

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
  String get instrumentBansuriDesc => 'पारंपरिक भारतीय बाँस की बाँसुरी';

  @override
  String get instrumentConcert => 'पश्चिमी कॉन्सर्ट फ्लूट';

  @override
  String get instrumentConcertDesc => 'मानक कॉन्सर्ट फ्लूट';

  @override
  String get instrumentNative => 'नेटिव अमेरिकन फ्लूट';

  @override
  String get instrumentNativeDesc => 'मूल अमेरिकी शैली';

  @override
  String get instrumentQuena => 'केना';

  @override
  String get instrumentQuenaDesc => 'एंडियन फ्लूट';

  @override
  String get instrumentRecorder => 'रिकॉर्डर';

  @override
  String get instrumentRecorderDesc => 'सोप्रानो / आल्टो रिकॉर्डर';

  @override
  String get instrumentChromatic => 'सार्वभौमिक क्रोमैटिक';

  @override
  String get instrumentChromaticDesc => 'सभी स्वर C–B';

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
  String get decrease => 'घटाएँ';

  @override
  String get increase => 'बढ़ाएँ';

  @override
  String get waitingForTone => 'स्वर की प्रतीक्षा';

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
