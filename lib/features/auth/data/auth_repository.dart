import 'package:fixora/features/auth/data/user_model.dart';

class AuthRepository {
  UserModel? _currentUser;
  UserModel? _registeredUser;
  String? _registeredPassword;

  Future<UserModel> login(String email, String password) async {
    if (_registeredUser == null) {
      throw Exception('No registered user');
    }

    if (email != _registeredUser!.email) {
      throw Exception('Invalid email');
    }
    if (password != _registeredPassword) {
      throw Exception('Wrong password');
    }

    _currentUser = _registeredUser;

    return _currentUser!;
  }

  Future<UserModel> register(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    final user = UserModel(id: '1', name: name, email: email, phone: phone);
    _registeredPassword = password;
    _registeredUser = user;
    _currentUser = user;
    return user;
  }

  Future<UserModel> getCurrentUser() async {
    if (_currentUser == null) {
      throw Exception('No user logged in');
    }

    return _currentUser!;
  }

  Future<UserModel> updateProfile(
    String name,
    String email,
    String phone,
  ) async {
    if (_currentUser == null) {
      throw Exception('No user logged in');
    }
    final user = UserModel(
      id: _currentUser!.id,
      name: name,
      email: email,
      phone: phone,
    );
    _currentUser = user;
    _registeredUser = user;
    return user;
  }

  void logout() {
    _currentUser = null;
  }
}
