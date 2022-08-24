import 'package:flutter/material.dart';
import 'package:node_flutter_auth/providers/user_provider.dart';
import 'package:node_flutter_auth/services/auth_service.dart';
import 'package:node_flutter_auth/utils/constants.dart';
import 'package:node_flutter_auth/views/home_screen.dart';
import 'package:node_flutter_auth/views/sign_up_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();
  @override
  void initState() {
    // printData();
    super.initState();
    _authService.getUserData(context);
  }

  // Future printData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? prefsToken = await prefs.getString('x-auth-token');
  //   print("shared pref token");
  //   print(prefsToken);
  //   print("provider token");
  //   String? providerToken = Provider.of<UserProvider>(context).userModel.token;
  //   print(providerToken);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Node Auth',
      theme: ThemeData(
        primarySwatch: Constants.primarySwatch,
      ),
      home: Provider.of<UserProvider>(context).userModel.token.isEmpty
          ? const SignUp()
          : const HomeScreen(),
    );
  }
}
