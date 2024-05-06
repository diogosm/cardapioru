import 'package:flutter/material.dart';

class SuggestionField extends StatelessWidget {
  const SuggestionField({
    super.key,
    required this.hint,
    required this.stream,
    required this.onChanged,
    required this.border,
    required this.minLines,
  });

  final String hint;
  final Stream<String> stream;
  final Function(String) onChanged;
  final bool border;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: stream,
        builder: (context, snapshot) {
          return TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              isCollapsed: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              border: border
                  ? const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                    )
                  : const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black26,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
              enabledBorder: border
                  ? const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                    )
                  : const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black26,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
              focusedBorder: border
                  ? const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                    )
                  : const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black26,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
              errorBorder: border
                  ? const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                    )
                  : const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black26,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
              focusedErrorBorder: border
                  ? const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                    )
                  : const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black26,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
              labelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 19,
              ),
              errorText: snapshot.hasError ? snapshot.error as String : null,
            ),
            keyboardType: TextInputType.text,
            minLines: minLines,
            maxLines: minLines,
            textAlign: TextAlign.justify,
            textCapitalization: TextCapitalization.sentences,
          );
        });
  }
}
