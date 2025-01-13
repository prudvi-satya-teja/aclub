import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final String? message;

  const CustomLoader({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                message!,
                style: const TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}
