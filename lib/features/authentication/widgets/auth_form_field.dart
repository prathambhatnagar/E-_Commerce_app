import 'package:flutter/material.dart';

class AuthFormField extends StatefulWidget {
  final String label;
  final bool isObscure;
  final Icon? prefixIcon;
  final TextEditingController textController;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final int lines;

  const AuthFormField(
      {super.key,
      this.lines = 1,
      required this.label,
      required this.textController,
      this.isObscure = false,
      this.prefixIcon,
      this.validator,
      this.inputType = null});
  @override
  State<AuthFormField> createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  late bool _isObscured;
  @override
  void initState() {
    _isObscured = widget.isObscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      _isObscured = widget.isObscure;
    }

    return TextFormField(
      maxLines: widget.lines,
      keyboardType: widget.inputType,
      validator: widget.validator,
      controller: widget.textController,
      obscureText: _isObscured,
      decoration: InputDecoration(
        hintText: widget.label,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isObscure
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                icon: Icon(_isObscured
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
              )
            : null,
      ),
    );
  }
}
