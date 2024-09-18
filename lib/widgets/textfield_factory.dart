import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TextFieldFactory {
  static Widget createTextField(
      BuildContext context,
      TextEditingController controller,
      String hintText,
      IconData prefixIcon,
      bool isError) {
    Color stateColor = isError ? paletteRed : paletteYellow;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style:
            Theme.of(context).textTheme.bodyMedium!.copyWith(color: stateColor),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
          prefixIcon: Icon(
            prefixIcon,
            size: 25,
            color: stateColor,
          ),
          suffixIcon: const Icon(null, size: 25),
          hintText: hintText,
          hintStyle: TextStyle(
            color: stateColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: stateColor, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: stateColor, width: 4),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  static Widget createObscureTextField(
      BuildContext context,
      TextEditingController controller,
      String hintText,
      IconData prefixIcon,
      bool isError) {
    return ObscureTextField(
      controller: controller,
      hintText: hintText,
      prefixIcon: prefixIcon,
      isError: isError,
    );
  }
}

class ObscureTextField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool isError;

  const ObscureTextField({
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    Key? key,
    required this.isError,
  }) : super(key: key);

  @override
  ObscureTextFieldState createState() => ObscureTextFieldState();
}

class ObscureTextFieldState extends State<ObscureTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Color stateColor = widget.isError ? paletteRed : paletteYellow;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        obscuringCharacter: 'x',
        textAlign: TextAlign.center,
        style:
            Theme.of(context).textTheme.bodyMedium!.copyWith(color: stateColor),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
          prefixIcon: Icon(
            widget.prefixIcon,
            size: 25,
            color: stateColor,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              size: 25,
              color: stateColor,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: stateColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: stateColor, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: stateColor, width: 4),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
