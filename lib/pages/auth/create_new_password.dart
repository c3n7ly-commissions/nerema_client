import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreatePasswordScreen extends StatefulWidget {
  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 5.0),
            child: CreatePasswordForm(),
          ),
        ),
      ),
    );
  }
}

class CreatePasswordForm extends StatefulWidget {
  @override
  _CreatePasswordFormState createState() => _CreatePasswordFormState();
}

class _CreatePasswordFormState extends State<CreatePasswordForm> {
  final _formKey = GlobalKey<FormState>();

  final _uniqueController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future resetPassword(String uid, String token, String pass) async {
    final response = await http.post(
      // TODO: Wait for this to be fixed
      // https://github.com/jazzband/dj-rest-auth/issues/269
      Uri.parse(
          'http://localhost:8000/api/v1/dj-rest-auth/password/reset/confirm/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'uid': uid,
        'token': token,
        'new_password1': pass,
        'new_password2': pass,
      }),
    );

    if (response.statusCode == 200) {
      // Successful request
      print("${response.statusCode} : ${response.body}");

      Navigator.pushNamed(context, '/reset-email-sent');
    } else if (response.statusCode == 400) {
      print("${response.statusCode} : ${response.body}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: <Widget>[
              Text(
                "Error: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Invalid credentials'),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      print("${response.statusCode} : ${response.body}");
    }
  }

  _submitForm() {
    if (_formKey.currentState!.validate()) {
      var uids = _uniqueController.text.split('.');

      String uid = uids[0];
      String token = uids[1];
      print("$uid $token");
      resetPassword(uid, token, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Center(
                child: Text(
                  'Create New Password',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: TextFormField(
                controller: _uniqueController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Unique Code',
                  labelText: 'Unique Code*',
                ),
                validator: (value) {
                  // Check 1
                  if (value == null || value.isEmpty) {
                    return "Please enter the code you received";
                  }

                  // Check 2
                  var uids = value.split('.');
                  if (uids.length <= 1 || uids.length > 2) {
                    return "Invalid token";
                  }

                  // All good
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  labelText: 'Password*',
                ),
                obscureText: true,
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your new password";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  labelText: 'Confirm Password*',
                ),
                obscureText: true,
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your new password again";
                  } else if (value != _passwordController.text) {
                    return "Passwords do not match.";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                'Fields marked with * sign are required',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Container(
                width: double.infinity,
                child: TextButton(
                  child: Text('Reset Password'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                  ),
                  onPressed: _submitForm,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Remember your password?'),
                  TextButton(
                    child: Text('Sign in here'),
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign-in');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
