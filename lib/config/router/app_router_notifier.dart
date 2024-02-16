import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {
  final AuthNofifier _authNofifier;
  AuthStatus _authStatus = AuthStatus.checking;

  AuthStatus get authStatus => _authStatus;

  GoRouterNotifier(this._authNofifier) {
    _authNofifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }

  set authStatus( AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}