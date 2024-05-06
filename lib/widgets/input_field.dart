import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      required this.hint,
      required this.obscure,
      required this.inputType,
      required this.stream,
      required this.onChanged,
      required this.needMask});

  final String hint;
  final bool obscure;
  final TextInputType inputType;
  final Stream<String> stream;
  final Function(String) onChanged;
  final bool needMask;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {

  late bool _obscurePassword;

  static const lightColor = Color.fromRGBO(234, 157, 19, 1);

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
  }

  @override
  Widget build(BuildContext context) {
    final maskFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: {'#' : RegExp(r'[0-9]')});

    return StreamBuilder<String>(
        stream: widget.stream,
        builder: (context, snapshot) {
          return TextField(
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(
                color: Colors.black38,
                fontSize: 20,
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black54, width: 1, style: BorderStyle.solid),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black54, width: 1, style: BorderStyle.solid),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black54, width: 1, style: BorderStyle.solid),
              ),
              labelStyle: const TextStyle(color: Colors.black),
              errorText: snapshot.hasError ? snapshot.error as String : null,
              suffixIcon: widget.obscure ? IconButton(
                icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: lightColor),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ) : null,
            ),
            obscureText: widget.obscure ? _obscurePassword : false,
            keyboardType: widget.inputType,
            inputFormatters: widget.needMask
                ? [maskFormatter]
                : null,
          );
        });
  }
}
