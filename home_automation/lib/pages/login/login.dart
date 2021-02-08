import 'package:flutter/material.dart';
import 'package:home_automation/pages/home/home.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Home Automation',
              style: TextStyle(fontSize: screenWidth * 0.065),
            ),
            Divider(
              color: Colors.transparent,
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Container(
                  width: screenWidth - 80, child: Center(child: Text("LOGIN"))),
            ),
          ],
        ),
      ),
    );
  }
}
