import 'package:cardapio_ufam/bloc/rating_bloc.dart';
import 'package:cardapio_ufam/widgets/suggestion_field.dart';
import 'package:flutter/material.dart';

class SuggestionScreen extends StatelessWidget {
  const SuggestionScreen({super.key, required this.ratingBloc});

  static const lightColor = Color.fromRGBO(234, 157, 19, 1);
  final RatingBloc ratingBloc;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                alignment: Alignment.topCenter,
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 230),
                child: Container(
                  height: 152,
                  padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Sair da página!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Você tem certeza que gostaria de voltar?",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text(
                              "CANCELAR",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              ratingBloc.submitOnlyAvalicao();
                              Navigator.pop(context, true);
                            },
                            child: const Text(
                              "SIM",
                              style: TextStyle(
                                color: Colors.green,
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
        return shouldPop;
      },
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(onPressed: () {
          //   Navigator.of(context)..pop()..pop();
          // },icon: const Icon(Icons.arrow_back),),
          backgroundColor: lightColor,
          title: const Text("Sugestão"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  SuggestionField(
                    hint: "Título",
                    stream: ratingBloc.outTitle,
                    onChanged: ratingBloc.changeTitle,
                    border: true,
                    minLines: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SuggestionField(
                    hint: "Escreva aqui sua sugestão...",
                    stream: ratingBloc.outText,
                    onChanged: ratingBloc.changeText,
                    border: false,
                    minLines: 5,
                  ),
                ],
              ),
              StreamBuilder<bool>(
                  stream: ratingBloc.outFilled2,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      onPressed: snapshot.hasData
                          ? () {
                        ratingBloc.submitWithSugestion();
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      alignment: Alignment.topCenter,
                                      insetPadding: const EdgeInsets.symmetric(
                                          horizontal: 36, vertical: 230),
                                      child: SingleChildScrollView(
                                        child: Container(
                                          height: 176,
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 20, 10, 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Obrigado por deixar sua sugestão!",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 21,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Clique no botão para voltar.",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      "VOLTAR",
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightColor,
                      ),
                      child: const Text(
                        "ENVIAR",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
