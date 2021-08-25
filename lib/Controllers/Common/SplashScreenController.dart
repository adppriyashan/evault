import 'package:identifyapp/Controllers/Auth/AuthController.dart';

class SplashScreenController {
  Future<bool> checkAuth() async {
    return await AuthController().checkAuth();
  }
}
