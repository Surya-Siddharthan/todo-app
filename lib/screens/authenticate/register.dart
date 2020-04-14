import 'package:flutter/material.dart';
import 'package:test_1/services/auth.dart';
import 'package:test_1/shared/constants.dart';
import 'package:test_1/shared/loading.dart';
class Register extends StatefulWidget {
  
  final Function toggleView;
  Register({this.toggleView});
 
 
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';
  String cnfrmPassword = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Sign up to to-do'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            label: Text('SignIn'),
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 6 ? 'Enter a password of length 6 or more' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Confirm Password'),
                validator: (val) => val != password ? "Passwords don't match" : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => cnfrmPassword = val);
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.regiterWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(()  {
                        error = 'please supply a valid email';
                        loading = false;  
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12,),
              Text(error,
              style: TextStyle(color: Colors.red, fontSize: 14), )
            ],
          ),
        ),

        ),
    );
  }
}