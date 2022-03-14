import 'package:flutter/material.dart';

class CustomTextFieldOutline extends StatefulWidget {
  const CustomTextFieldOutline(
      {Key? key, this.hintText, this.label, this.onChange})
      : super(key: key);

  final String? hintText;
  final String? label;
  final void Function(String value)? onChange;

  @override
  _CustomTextFieldOutlineState createState() => _CustomTextFieldOutlineState();
}

class _CustomTextFieldOutlineState extends State<CustomTextFieldOutline> {
  bool showPassword = false;
  TextEditingController controller = TextEditingController();
  bool? invalid;

  void _onChange(String value) {
    if (value.isEmpty) {
      setState(() {
        invalid = true;
      });
    }
  }

  void _changePwdType() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: showPassword,
      controller: controller,
      onChanged: (value) => _onChange(value),
      decoration: InputDecoration(
        suffixIcon: invalid == null
            ? null
            : invalid == true
                ? Icon(Icons.close)
                : IconButton(
                    icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: _changePwdType,
                  ),
        hintText: widget.hintText != null ? widget.hintText : null,
        labelText: widget.label != null ? widget.label : null,
      ),
    );
  }
}
