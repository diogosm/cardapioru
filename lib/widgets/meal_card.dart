import 'package:cardapio_ufam/screens/rating_screen.dart';
import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  const MealCard({super.key, required this.image, required this.idCardapio, required this.items, required this.tipo, required this.media, required this.preco});

  final String image;
  final String idCardapio;
  final String media;
  final String tipo;
  final String preco;
  final List<String> items;
  static const lightMainColor = Color.fromRGBO(234, 157, 19, 1);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: listar(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> listar(BuildContext context) {
    var listinha = <Widget>[textWithBorder(tipo.toUpperCase(), Colors.black.withAlpha(150),
        true, false, false)];
    items.sort();
    for(String i in items) {
      listinha.add(
        textWithBorder(i, Colors.black38, false, true, false));
    }
    listinha.removeLast();
    listinha.add(
        textWithBorder(items.last, Colors.black38, false, true, true));

    listinha.add(Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => RatingScreen(idCardapio: idCardapio, media: media,)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: lightMainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "AVALIAR!",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        Text(
          "R\$$preco",
          style: const TextStyle(
              color: lightMainColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ],
    ));
    return listinha;
  }

  Widget textWithBorder(
      String text, Color color, bool bold, bool padding, bool last) {
    return Container(
      height: 36,
      padding: padding
          ? const EdgeInsets.only(
              left: 10,
            )
          : EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      decoration: last
          ? const BoxDecoration()
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: color,
                ),
              ),
            ),
      child: Text(
        text,
        style: TextStyle(
            color: color,
            fontWeight: bold ? FontWeight.bold : FontWeight.w400,
            fontSize: 16),
        textAlign: TextAlign.start,
      ),
    );
  }
}
