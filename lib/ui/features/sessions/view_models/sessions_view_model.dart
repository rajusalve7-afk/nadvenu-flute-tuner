import 'package:flutter/foundation.dart';

import '../../../../data/repositories/session_repository.dart';
import '../../../../domain/models/tuning_session.dart';

/// Exposes the session log to the sessions screen.
class SessionsViewModel extends ChangeNotifier {
  SessionsViewModel(this._repository) {
    _repository.addListener(notifyListeners);
  }

  final SessionRepository _repository;

  List<TuningSession> get sessions => _repository.sessions;

  @override
  void dispose() {
    _repository.removeListener(notifyListeners);
    super.dispose();
  }
}
