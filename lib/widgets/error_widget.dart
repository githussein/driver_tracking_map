import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            color: Theme.of(context).primaryColorDark,
            child: const Text('Try again',
                style: TextStyle(fontWeight: FontWeight.w700)),
            onPressed: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const MyHomePage(title: 'title')),
              // );
            },
          ),
        ],
      ),
    );
  }
}
