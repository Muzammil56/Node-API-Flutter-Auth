import 'package:flutter/material.dart';
import 'package:node_flutter_auth/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _userModel = UserModel(
    email: '',
    id: '',
    name: '',
    password: '',
    token: '',
  );

  UserModel get userModel => _userModel;

  void setUser(String userModel) {
    _userModel = UserModel.fromJson(userModel);
    notifyListeners();
  }

  void setUserFromModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }
}
