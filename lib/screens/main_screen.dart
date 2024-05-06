import 'package:cardapio_ufam/bloc/choose_bloc.dart';
import 'package:cardapio_ufam/widgets/custom_drawer.dart';
import 'package:cardapio_ufam/widgets/drop_calendar.dart';
import 'package:cardapio_ufam/widgets/drop_menu.dart';
import 'package:cardapio_ufam/widgets/meal_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key, required this.token});

  final String token;
  static const mainColor = Color.fromRGBO(198, 126, 20, 1);
  static const lightMainColor = Color.fromRGBO(234, 157, 19, 1);
  final _chooseBloc = ChooseBloc();

  @override
  Widget build(BuildContext context) {
    const places = <String>["RU - Setor Norte", "RU - Setor Sul"];

    _chooseBloc.outLocal.listen((event) {
      _chooseBloc.setLocal();
    });

    _chooseBloc.outDate.listen((event) {
      _chooseBloc.setDate();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightMainColor,
        title: const Text("Cardápio UFAM"),
      ),
      drawer: const CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 32,
        ),
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropMenu(
                      ddList: places,
                      upper: true,
                      onChanged: _chooseBloc.localValue,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DropCalendar(
                      onChanged: _chooseBloc.dateValue,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    StreamBuilder(
                        stream: _chooseBloc.outInfos,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return FutureBuilder(
                                future: fetchAlbum(snapshot.data!),
                                builder: (context, snapshot) {
                                  print(snapshot?.data);
                                  if (snapshot.data == null) {
                                    print("Está nulo");
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          height: 130,
                                          width: double.maxFinite,
                                          child: Card(
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Text("Sem cardápio", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: mainColor),),
                                                  Container(height: 1 ,color: mainColor,),
                                                  const SizedBox(height: 15,),
                                                  const Text("Parece que ainda não foi inserido um cardápio para este dia e local!", style: TextStyle(fontSize: 16,),textAlign: TextAlign.center),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.data != null) {
                                    return Column(children: [
                                      MealCard(
                                        image: "assets/imgs/cafe_da_manha.png",
                                        idCardapio:
                                            snapshot.data!['cardapioDesjejum']
                                                ['idCardapio'],
                                        items: snapshot
                                            .data!['cardapioDesjejum']['items']
                                            .map<String>((item) =>
                                                item['descricao'] as String)
                                            .toList(),
                                        tipo: 'Desjejum',
                                        media: snapshot.data!['cardapioDesjejum']['cardapioMedia'].toString(),
                                        preco: '0,70',
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      MealCard(
                                        image: "assets/imgs/almoco.png",
                                        idCardapio:
                                            snapshot.data!['cardapioAlmoco']
                                                ['idCardapio'],
                                        items: snapshot.data!['cardapioAlmoco']
                                                ['items']
                                            .map<String>((item) =>
                                                item['descricao'] as String)
                                            .toList(),
                                        tipo: 'Almoço',
                                        media: snapshot.data!['cardapioAlmoco']['cardapioMedia'].toString(),
                                        preco: '1,20',
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      MealCard(
                                        image: "assets/imgs/jantar.jpg",
                                        idCardapio:
                                            snapshot.data!['cardapioJantar']
                                                ['idCardapio'],
                                        items: snapshot.data!['cardapioJantar']
                                                ['items']
                                            .map<String>((item) =>
                                                item['descricao'] as String)
                                            .toList(),
                                        tipo: 'Jantar',
                                        media: snapshot.data!['cardapioJantar']['cardapioMedia'].toString(),
                                        preco: '1,30',
                                      ),
                                    ]);
                                  } else {
                                    return const SizedBox(
                                      height: 500,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        color: mainColor,
                                      )),
                                    );
                                  }
                                });
                          } else {
                            if (snapshot.data == null) {
                              return Container(
                                color: Colors.blue,
                              );
                            } else {
                              return const SizedBox(
                                height: 500,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: mainColor,
                                )),
                              );
                            }
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> fetchAlbum(Map<String, String> data) async {
    String url =
        'https://ruwebservicedev.ufam.edu.br/v1/cardapioDia/${data["local"]}/${data["data"]}';
    print(url.length);
    if (url.length != 77) {
      var p1 = url.substring(0, 61);
      var p2 = url.substring(61, 76);
      url = '${p1}0$p2';
    }
    try {
      Response response = await Dio().get(url);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

// 53 caracteres sem data  -- 61 até o local do 0
}
