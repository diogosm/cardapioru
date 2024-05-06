import 'package:cardapio_ufam/bloc/rating_bloc.dart';
import 'package:cardapio_ufam/screens/suggestion_screen.dart';
import 'package:cardapio_ufam/widgets/ratio_button.dart';
import 'package:flutter/material.dart';

class RatingScreen extends StatelessWidget {
  RatingScreen({super.key, required this.idCardapio, required this.media});

  final String idCardapio;
  static const darkColor = Color.fromRGBO(188, 122, 15, 1.0);
  static const lightColor = Color.fromRGBO(234, 157, 19, 1);
  static const textColor = Color.fromRGBO(94, 94, 94, 1);

  final String media;
  final _ratingBloc = RatingBloc();

  @override
  Widget build(BuildContext context) {
    _ratingBloc.idCardapio = idCardapio;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        title: const Text("Avaliação"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Avaliação Atual:",
                style: TextStyle(
                  color: darkColor,
                  fontSize: 24,
                  fontFamily: "Roboto_Slab",
                  letterSpacing: 0,
                ),
              ),
              Text(
                media == "0" ? "-" : media,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 80,
                  color: textColor,
                  fontFamily: "Roboto_Slab",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: stars(media),
              ),
              Text(
                avaliacao(media),
                style: const TextStyle(
                  color: darkColor,
                  fontSize: 22,
                  fontFamily: "Roboto_Slab",
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 28,
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: textColor,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Como você avalia a comida?",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Roboto_Slab",
                          ),
                        ),
                      ),
                      RatioButton(
                        type: "food",
                        ratingBloc: _ratingBloc,
                      ),
                      Container(
                        height: 28,
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: textColor,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Como você avalia o atendimento?",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Roboto_Slab",
                          ),
                        ),
                      ),
                      RatioButton(
                        type: "service",
                        ratingBloc: _ratingBloc,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          StreamBuilder<bool>(
                              stream: _ratingBloc.outFilled,
                              builder: (context, snapshot) {
                                return SizedBox(
                                  height: 30,
                                  child: TextButton(
                                    onPressed: snapshot.hasData
                                        ? () {
                                            Navigator.pop(context);
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    alignment:
                                                        Alignment.topCenter,
                                                    insetPadding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 36,
                                                        vertical: 230),
                                                    child: Container(
                                                      height: 152,
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          20, 20, 10, 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        color: Colors.white,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Obrigado pela Avaliação!",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 21,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                            "Gostaria de deixar uma sugestão?",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            mainAxisSize:
                                                                MainAxisSize.min,
                                                            children: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  _ratingBloc.submitOnlyAvalicao();
                                                                },
                                                                child: const Text(
                                                                  "NÃO",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize: 18,
                                                                  ),
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pushReplacement(
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              SuggestionScreen(ratingBloc: _ratingBloc,),
                                                                    ),
                                                                  );
                                                                },
                                                                child: const Text(
                                                                  "SIM",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontSize: 18,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }
                                        : null,
                                    style: ButtonStyle(
                                      alignment: Alignment.centerRight,
                                      splashFactory: NoSplash.splashFactory,
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 0),
                                      ),
                                    ),
                                    child: Text(
                                      "FINALIZAR",
                                      style: snapshot.hasData
                                          ? const TextStyle(
                                              color: lightColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)
                                          : TextStyle(
                                              color: lightColor.withAlpha(50),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String avaliacao(String media) {
    int m = double.parse(media).toInt();
    switch(m) {
      case 0:
        return "Sem avaliação";
      case 1:
        return "Péssimo";
      case 2:
        return "Ruim";
      case 3:
        return "Regular";
      case 4:
        return "Bom";
      case 5:
        return "Ótimo";
      default:
        return "Sem avaliação";
    }
  }

  List<Widget> stars(String media) {
    double s = double.parse(media);
    int pintada = s.toInt();
    var listinha = <Widget>[];

    for(int i = 0; i < pintada; i++) {
      listinha.add(const Icon(Icons.star, size: 40, color: lightColor,),);
    }

    for(int i = pintada; i < 5; i++) {
      listinha.add(const Icon(Icons.star_outline, size: 40, color: lightColor,));
    }
    return listinha;
  }

}
