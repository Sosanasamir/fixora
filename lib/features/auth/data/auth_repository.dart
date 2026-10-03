import 'package:fixora/features/auth/data/user_model.dart';

class AuthRepository {
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return UserModel(
      id: '1',
      name: 'sosana',
      email: email,
      phone: '010000000000',
    );
  }

  Future<UserModel> register(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    await Future.delayed(Duration(seconds: 2));
    return UserModel(id: '1', name: name, email: email, phone: phone);
  }

  Future<UserModel> getCurrentUser() async {
    await Future.delayed(Duration(seconds: 2));
    return UserModel(
      id: '1',
      name: 'sosana',
      email: 'sosana@gmail.com',
      phone: '01293385783',
    );
  }
}
