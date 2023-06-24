import 'package:flutter/material.dart';

import '../models/users.dart';

class UserProvider extends ChangeNotifier {
  Users _users = Users('', '', '', '', '', '', '');
  Users get users => _users;
  void setUser(String user) {
    _users = Users.fromJson(user);
    notifyListeners();
  }
}
