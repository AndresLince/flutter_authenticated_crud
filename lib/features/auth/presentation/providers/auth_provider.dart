import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

import '../../domain/entities/user.dart';

final authProvider = StateNotifierProvider<AuthNofifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl(dataSource);
  return AuthNofifier();
});

class AuthNofifier extends StateNotifier<AuthState> {
  AuthNofifier(): super(AuthState());

  void LoginUser(String email, String password) async {

  }

  void registerUser(String email, String password) async {

  }

  void checkAuthStatus() async {

  }
}

enum AuthStatus {
  checking, authenticated, notAuthenticated
}

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;
  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = ''
  });
  
  AuthState copyWith(
      AuthStatus? authStatus,
      User? user,
      String? errorMessage,
  ) => AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
  );
}
