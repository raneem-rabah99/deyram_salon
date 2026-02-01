import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserCubit extends Cubit<Map<String, String?>> {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  UserCubit() : super({});

  Future<void> loadUserData() async {
    String? username = await _secureStorage.read(key: 'username');
    String? imagePath = await _secureStorage.read(key: 'image');
    emit({'username': username, 'image': imagePath});
  }
}
