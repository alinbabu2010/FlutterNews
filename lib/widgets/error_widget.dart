import 'package:flutter/material.dart';

class EmptyMsgWidget extends StatelessWidget {
  final String message;
  final bool isScrollNeeded;

  const EmptyMsgWidget({
    Key? key,
    required this.message,
    required this.isScrollNeeded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final textTheme = Theme.of(context).textTheme;
    return !isScrollNeeded
        ? Center(
            child: Text(
              message,
              style: textTheme.bodyMedium
                  ?.copyWith(color: Colors.deepOrangeAccent),
              textAlign: TextAlign.center,
            ),
          )
        : SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: mediaQuery.size.height * 0.88,
              child: Center(
                child: Text(
                  message,
                  style: textTheme.bodyLarge?.copyWith(color: Colors.redAccent),
                ),
              ),
            ),
          );
  }
}
