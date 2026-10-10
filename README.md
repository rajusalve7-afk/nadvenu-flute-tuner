# Nadvenu Flute Tuner Pro

Tune Your Soul. A dark-gold flute tuner for Indian bansuri, concert flute, Native American flute, quena, recorder, and chromatic practice.

The needle reads cents from −50 to +50. Sa follows the root you pick, with shuddha, komal, and tivra swaras. G is Pa when Sa is C. A4 is adjustable (432, 440, and 442 are presets). 440 Hz is marked as the modern standard.

Pitch math lives in pure Dart. Settings and tuning sessions stay on the device. There is no account and no backend. The Pro screen is a local preview: Upgrade and Restore do not charge a payment.

If the microphone is blocked, the app stays in **demo mode** and moves the needle, waveform, and analysis chart with a built-in tone. A stable in-tune reading is saved to Tuning Sessions.

## Run

Install Flutter stable, then from this directory:

```bash
flutter pub get
flutter run
```

Web (this is the browser build):

```bash
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 47291
```

Open `http://127.0.0.1:47291`.

On a phone or tablet:

```bash
flutter devices
flutter run -d <device-id>
```

Android needs microphone permission. iOS asks with the usage string in `Info.plist`. Demo mode does not need a microphone.

## Tests

```bash
flutter test
```

Unit tests cover equal temperament, sargam (including Pa when Sa is C), just intonation, the in-tune lock, and pitch detection. A widget test covers the main tuner.

## Languages

English, हिन्दी, मराठी, ગુજરાતી, বাংলা, தமிழ், and తెలుగు. The choice is saved.
