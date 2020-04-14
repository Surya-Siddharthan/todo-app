import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_1/screens/authenticate/authenticate.dart';
import 'package:test_1/screens/home/home.dart';
import 'package:test_1/models/user.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    //return home or authenticate
    if(user == null) {
      return Authenticate();
    }
    else {
      return Home();
    }
  }
}