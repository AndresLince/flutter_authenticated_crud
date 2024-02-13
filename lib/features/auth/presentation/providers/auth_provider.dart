import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

import '../../domain/entities/user.dart';

final authProvider = StateNotifierProvider<AuthNofifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  return AuthNofifier(authRepository: authRepository);
});

class AuthNofifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  AuthNofifier({
    required this.authRepository,
  }): super(AuthState());

  Future<void> loginUser(String email, String password) async {
    try{
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void registerUser(String email, String password) async {

  }

  void checkAuthStatus() async {

  }

  void _setLoggedUser(User user) {
    // TODO: necesito guardar el token en el dispositivo
    state = state.copyWith(authStatus: AuthStatus.authenticated, user: user, errorMessage: '', );
  }

  Future<void> logout([String? errorMessage]) async {
    //TODO: limpiar token
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage
    );
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
  
  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
  );
}
