import '../../domain/models/app_settings.dart';
import '../../domain/models/swara.dart';
import '../../domain/models/tuning_result.dart';
import '../../l10n/generated/app_localizations.dart';

String swaraSyllable(AppLocalizations l10n, Swara swara) {
  return switch (swara.degree) {
    0 => l10n.swaraSa,
    1 => l10n.swaraRe,
    2 => l10n.swaraGa,
    3 => l10n.swaraMa,
    4 => l10n.swaraPa,
    5 => l10n.swaraDha,
    _ => l10n.swaraNi,
  };
}

String variantLabel(AppLocalizations l10n, SwaraVariant variant) {
  return switch (variant) {
    SwaraVariant.komal => l10n.komal,
    SwaraVariant.tivra => l10n.tivra,
    SwaraVariant.shuddha => '',
  };
}

String instrumentName(AppLocalizations l10n, InstrumentId id) {
  return switch (id) {
    InstrumentId.bansuri => l10n.instrumentBansuri,
    InstrumentId.concert => l10n.instrumentConcert,
    InstrumentId.nativeAmerican => l10n.instrumentNative,
    InstrumentId.quena => l10n.instrumentQuena,
    InstrumentId.recorder => l10n.instrumentRecorder,
    InstrumentId.chromatic => l10n.instrumentChromatic,
  };
}

String instrumentDescription(AppLocalizations l10n, InstrumentId id) {
  return switch (id) {
    InstrumentId.bansuri => l10n.instrumentBansuriDesc,
    InstrumentId.concert => l10n.instrumentConcertDesc,
    InstrumentId.nativeAmerican => l10n.instrumentNativeDesc,
    InstrumentId.quena => l10n.instrumentQuenaDesc,
    InstrumentId.recorder => l10n.instrumentRecorderDesc,
    InstrumentId.chromatic => l10n.instrumentChromaticDesc,
  };
}

String statusLabel(AppLocalizations l10n, TuningStatus status) {
  return switch (status) {
    TuningStatus.inTune => l10n.inTune,
    TuningStatus.flat => l10n.flat,
    TuningStatus.sharp => l10n.sharp,
  };
}

String languageLabel(AppLocalizations l10n, String code) {
  return switch (code) {
    'hi' => l10n.languageNameHi,
    'mr' => l10n.languageNameMr,
    'gu' => l10n.languageNameGu,
    'bn' => l10n.languageNameBn,
    'ta' => l10n.languageNameTa,
    'te' => l10n.languageNameTe,
    _ => l10n.languageNameEn,
  };
}

const supportedLanguageCodes = ['en', 'hi', 'mr', 'gu', 'bn', 'ta', 'te'];
