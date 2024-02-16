import 'package:flutter/foundation.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';

class GoRouterNotifier extends ChangeNotifier {
  final AuthNofifier _authNofifier;
  AuthStatus _authStatus = AuthStatus.checking;

  AuthStatus get authStatus => _authStatus;

  GoRouterNotifier(this._authNofifier);

  set authStatus( AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}