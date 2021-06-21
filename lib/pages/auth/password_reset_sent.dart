import 'package:flutter/material.dart';

class ResetEmailSentScreen extends StatefulWidget {
  @override
  _ResetEmailSentState createState() => _ResetEmailSentState();
}

class _ResetEmailSentState extends State<ResetEmailSentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 5.0),
            child: Container(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Check your email',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 50,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      "If an account exists for the entered email address, you'll " +
                          "receive an e-mail with password reset details. " +
                          "In some cases you might have to look in your spam folder.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      "Check your inbox and copy the sent unique keys.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Email not received?'),
                        TextButton(
                          child: Text('Send again.'),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/send-again');
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: double.infinity,
                      child: TextButton(
                        child: Text('Set New Password'),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/sign-in');
                        },
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
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
          ),
        ),
      ),
    );
  }
}
