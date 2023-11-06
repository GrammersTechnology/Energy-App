import 'package:flutter/material.dart';

class NewBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final child;
  const NewBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 240,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // darker shadow on the bottom right
          BoxShadow(
            color: Colors.grey.shade600,
            blurRadius: 15,
            offset: const Offset(5, 5),
          ),

          //lighter shadow on the top left
          const BoxShadow(
            color: Colors.white,
            blurRadius: 15,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
