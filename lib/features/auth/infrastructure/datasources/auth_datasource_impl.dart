import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/errors/auth_errors.dart';
import 'package:teslo_shop/features/auth/infrastructure/mappers/user_mapper.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  );
  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
     try{
       final response = await dio.post('/auth/login', data: {
         'email': email,
         'password': password,
       });
       final user = UserMapper.userJsonToEntity(response.data);
       return user;
     } on DioException catch (e) {
       if (e.response?.statusCode == 401)  throw WrongCredentials();
       if (e.type == DioExceptionType.connectionTimeout) throw ConnectionTimeOut();
       throw CustomError('Something wrong happen', 500);
     } catch (e) {
       throw Exception(e);
     }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
  
}