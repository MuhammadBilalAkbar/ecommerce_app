import 'package:flutter/material.dart';
import '../screens/sign_in_screen.dart';
import 'services/push_notifications_api.dart';
import 'utils/user_secure_storage.dart';
import 'screens/home_screen.dart';

class CheckStatus extends StatefulWidget {
  const CheckStatus({super.key});

  @override
  State<CheckStatus> createState() => _CheckStatusState();
}

class _CheckStatusState extends State<CheckStatus> {
  final FirebaseApi _firebaseApi = FirebaseApi();
  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    await _firebaseApi.initNotifications(context);
  }
  Future<bool> checkLoginStatus() async {
    final uid = await UserSecureStorage.read('uid');
    debugPrint('uid: $uid');
    if (uid == null) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.data == false) {
            return const SignInScreen();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const HomeScreen();
        },
      );
}
