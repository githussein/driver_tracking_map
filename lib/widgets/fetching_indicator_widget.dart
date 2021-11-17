import 'package:flutter/material.dart';

class FetchingIndicator extends StatelessWidget {
  const FetchingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Fetching data from the server...'),
        ],
      ),
    );
  }
}
