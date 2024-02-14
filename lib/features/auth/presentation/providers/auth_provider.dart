import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

import '../../../shared/infrastructure/services/key_value_storage_service.dart';
import '../../../shared/infrastructure/services/key_value_storage_service_impl.dart';
import '../../domain/entities/user.dart';

final authProvider = StateNotifierProvider<AuthNofifier, AuthState>((ref) {
  final keyValueStorageService = KeyValueStorageServiceImpl();
  final authRepository = AuthRepositoryImpl();
  return AuthNofifier(authRepository: authRepository, keyValueStorageService: keyValueStorageService,);
});

class AuthNofifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;
  AuthNofifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }): super(AuthState()) {
    checkAuthStatus();
  }

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

  void _setLoggedUser(User user) async {
    await keyValueStorageService.setKeyValue('token', user.token);

    state = state.copyWith(authStatus: AuthStatus.authenticated, user: user, errorMessage: '', );
  }

  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageService.removeKey('token');

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
