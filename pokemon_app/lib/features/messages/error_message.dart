import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final VoidCallback? onPressedTryAgain;

  const ErrorMessage({
    super.key,
    required this.onPressedTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Failed to get data.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Please, check your internet connection.',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onPressedTryAgain,
            child:
                Text('Try again', style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
