import 'package:flutter/material.dart';
import 'package:node_flutter_auth/services/auth_service.dart';
import 'package:node_flutter_auth/views/sign_in_screen.dart';
import 'package:node_flutter_auth/views/widgets/custom_button.dart';
import 'package:node_flutter_auth/views/widgets/custom_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  void SignUpFunction() {
    _authService.signUpUser(
      context: context,
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome!",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              controller: _nameController,
              hintText: "Name",
              paddingHeight: 10,
              paddingWidth: 10,
            ),
            CustomTextField(
              controller: _emailController,
              hintText: "Email",
              paddingHeight: 0,
              paddingWidth: 10,
            ),
            CustomTextField(
              controller: _passwordController,
              hintText: "Password",
              paddingHeight: 10,
              paddingWidth: 10,
            ),
            InkWell(
              onTap: () => SignUpFunction(),
              child: CustomButton(
                label: "Sign Up",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an Account? "),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                      (route) => false),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
