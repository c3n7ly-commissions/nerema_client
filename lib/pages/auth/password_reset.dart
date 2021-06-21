import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PasswordResetScreen extends StatefulWidget {
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 5.0),
            child: PasswordResetForm(),
          ),
        ),
      ),
    );
  }
}

class PasswordResetForm extends StatefulWidget {
  @override
  _PasswordResetFormState createState() => _PasswordResetFormState();
}

class _PasswordResetFormState extends State<PasswordResetForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  Future resetPassword(String email) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/v1/dj-rest-auth/password/reset/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      // Successful request
      print("${response.statusCode} : ${response.body}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: <Widget>[
              Text(
                "Success: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Reset details have been sent to your e-mail'),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );
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
      resetPassword(_emailController.text);
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
              padding: EdgeInsets.only(bottom: 5.0),
              child: Center(
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Center(
                child: Text(
                  'Enter your email to reset your password',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'E-mail',
                  labelText: 'E-mail*',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your e-mail";
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
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Remember your password?',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        // fontSize: 16,
                      ),
                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
