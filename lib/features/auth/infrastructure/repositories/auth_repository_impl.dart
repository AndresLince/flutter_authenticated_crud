import 'package:teslo_shop/features/auth/domain/domain.dart';
import '../datasources/auth_datasource_impl.dart';

class AuthRepositoryImpl extends AuthRepository {

  final AuthDataSource dataSource;
  AuthRepositoryImpl(
    AuthDataSource? dataSource
  ): dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}