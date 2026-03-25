import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isPassword;
  final int maxLines;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();

    _isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _isObscure : false,
        maxLines: widget.maxLines,
        style: TextStyle(fontSize: 18, color: Colors.white),
        validator: (text) => text == null || text.isEmpty
            ? 'Please Enter ${widget.label}'
            : null,

        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          labelText: widget.label,
          labelStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.black26,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: _isObscure
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  color: Colors.white70,
                  onPressed: () {
                    //press to change visibility
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
