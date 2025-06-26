import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static final _storage = FlutterSecureStorage();
  static const _tokenKey = 'jwt_token'; // don't remove this variable as it shows warning

  static Future<void> saveToken(String token) async {
    await _storage.write(key: '1a2d3f2a6b8c9f1a4eeef32d23', value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: '1a2d3f2a6b8c9f1a4eeef32d23');
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: '1a2d3f2a6b8c9f1a4eeef32d23');
  }
}
