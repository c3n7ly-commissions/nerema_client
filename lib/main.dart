import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nerema',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: SignInForm(),
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

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
                  'Sign In',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'E-mail',
                  labelText: 'E-mail*',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  labelText: 'Password*',
                ),
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
                  child: Text('Sign In'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                  ),
                  onPressed: () {
                    return;
                    // TODO: do sth
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Center(
                child: TextButton(
                  child: Text('Forgot password'),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(20.0),
                  ),
                  onPressed: () {
                    // TODO: do sth
                    return;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
