import 'package:flutter/material.dart';
import 'package:node_flutter_auth/services/auth_service.dart';
import 'package:node_flutter_auth/views/sign_up_screen.dart';
import 'package:node_flutter_auth/views/widgets/custom_button.dart';
import 'package:node_flutter_auth/views/widgets/custom_text_field.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Sign In!",
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
            onTap: () => SignInFunction(
              context: context,
              email: _emailController.text,
              password: _passwordController.text,
            ),
            child: CustomButton(
              label: "Log In",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an Account? "),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ),
                    (route) => false),
                child: Text(
                  "Sign Up",
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
    );
  }

  void SignInFunction(
      {required BuildContext context,
      required String email,
      required String password}) {
    print("we are in sign in function");
    _authService.signInUser(context: context, email: email, password: password);
  }
}
