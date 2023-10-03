import 'package:flutter/material.dart';

class TextFromFieldWidget extends StatefulWidget {
  const TextFromFieldWidget({
    Key? key,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    this.showPasswordToggle = false,
  }) : super(key: key);

  final String hint;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool showPasswordToggle;

  @override
  TextFromFieldWidgetState createState() => TextFromFieldWidgetState();
}

class TextFromFieldWidgetState extends State<TextFromFieldWidget> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final List<Widget> suffixIcons = [];
    if (widget.showPasswordToggle) {
      suffixIcons.add(
        GestureDetector(
          onTap: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          child: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
        ),
      );
    }

    return TextFormField(
      controller: widget.controller,
      obscureText: widget.showPasswordToggle ? isObscure : false,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.prefixIcon),
        hintText: widget.hint,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: suffixIcons,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
  }
}
