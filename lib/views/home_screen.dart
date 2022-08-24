import 'package:flutter/material.dart';
import 'package:node_flutter_auth/views/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserProvider>(context).userModel;
    final AuthService _authService = AuthService();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_userModel.email),
            Text(_userModel.name),
            Text(_userModel.id),
            InkWell(
              onTap: () => _authService.SignOutFunction(
                context: context,
              ),
              child: CustomButton(
                label: "Log In",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
