import 'package:cardapio_ufam/bloc/rating_bloc.dart';
import 'package:flutter/material.dart';

class RatioButton extends StatefulWidget {
  const RatioButton({
    super.key, required this.type, required this.ratingBloc,
  });

  final String type;
  final RatingBloc ratingBloc;

  @override
  State<RatioButton> createState() => _RatioButtonState();
}

class _RatioButtonState extends State<RatioButton> {
  static const textColor = Color.fromRGBO(94, 94, 94, 1);

  static const List<String> options = [
    "Ótimo",
    "Bom",
    "Regular",
    "Ruim",
    "Péssimo",
  ];

  List<bool> pressed = [
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Column(
        children: options
            .map((text) => SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      IconButton(
                        constraints: const BoxConstraints(minWidth: 38),
                        alignment: Alignment.centerLeft,
                        onPressed: () {
                          setState(() {
                            pressed = [
                              false,
                              false,
                              false,
                              false,
                              false,
                            ];
                            pressed[options.indexOf(text)] = true;
                          });
                          widget.ratingBloc.sinkItem(widget.type, text);
                        },
                        splashRadius: 0.1,
                        padding: EdgeInsets.zero,
                        icon: pressed[options.indexOf(text)]
                            ? const Icon(
                                Icons.circle,
                                color: textColor,
                              )
                            : const Icon(
                                Icons.circle_outlined,
                                color: textColor,
                              ),
                      ),
                      Text(
                        text,
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
