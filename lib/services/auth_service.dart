import 'dart:convert';
import 'package:node_flutter_auth/views/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:node_flutter_auth/models/user_model.dart';
import 'package:node_flutter_auth/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:node_flutter_auth/providers/user_provider.dart';
import 'package:node_flutter_auth/utils/constants.dart';
import 'package:node_flutter_auth/views/home_screen.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserModel userModel = UserModel(
        email: email,
        id: '',
        name: name,
        password: password,
        token: '',
      );
      http.Response responce = await http.post(
        Uri.parse(Constants.signUpUrl),
        body: userModel.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        responce: responce,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Great, Account Created!');
        },
      );
    } catch (e) {
      showSnackBar(context, "${e.toString()}");
    }
  }

  void signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      final UserModel _userModel = UserModel(
          id: '', name: '', email: email, token: '', password: password);
      http.Response response = await http.post(
        Uri.parse(Constants.signInUrl),
        body: _userModel.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        responce: response,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(response.body);
          await prefs.setString(
              "x-auth-token", jsonDecode(response.body)['token']);
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get User Data
  void getUserData(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");
      if (token == null) {
        prefs.setString("x-auth-token", '');
      }

      var tokenResponse = await http.post(
        Uri.parse(Constants.authenticationUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenResponse.body);

      if (response == true) {
        http.Response userResponse = await http.get(
          Uri.parse(Constants.uriWithSlash),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  SignOutFunction({required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const SignUp(),
      ),
      (route) => false,
    );
  }
}
