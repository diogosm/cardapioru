import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cardapio_ufam/repositories/token_repository.dart';
import 'package:cardapio_ufam/validators/suggestion_validator.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class RatingBloc extends BlocBase with SuggestionValidator{

  late final idCardapio;
  final _foodRating = BehaviorSubject<String>();
  final _serviceRating = BehaviorSubject<String>();

  Stream<String> get outFood => _foodRating.stream;

  Stream<String> get outService => _serviceRating.stream;

  Stream<bool> get outFilled =>
      Rx.combineLatest2(outFood, outService, (a, b) => true);

  Function(String) get foodRating => _foodRating.sink.add;

  Function(String) get serviceRating => _serviceRating.sink.add;

  void sinkItem(String type, String text) {
    if(type == "food") {
      _foodRating.sink.add(text);
    } else {
      _serviceRating.sink.add(text);
    }
  }

  Future<void> submitOnlyAvalicao() async{
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://ruwebservicedev.ufam.edu.br/",
        contentType: "application/json",
      ),
    );

    final token = await TokenRepository().getToken();

    print(token);

    dio.options.headers['Authorization'] = 'Bearer $token';
    print({"idCardapio": idCardapio, "avaliacoes": [
      {"tipoAvaliacaoItem": "1", "statusAvaliacaoItem": returnValor(_foodRating.value).toString()},
      {"tipoAvaliacaoItem": "2", "statusAvaliacaoItem": returnValor(_serviceRating.value).toString()}
    ]});

    print("Na avaliacoa");

    try{
      Response response = await dio.post("v1/avaliacao", data: {"idCardapio": idCardapio, "sugestao": "", "avaliacoes": [
        {"tipoAvaliacaoItem": "1", "statusAvaliacaoItem": returnValor(_foodRating.value).toString()},
        {"tipoAvaliacaoItem": "2", "statusAvaliacaoItem": returnValor(_serviceRating.value).toString()}
      ]});
      print("Avaliou");
    } catch (e) {
      print(e);
    }
  }

  Future<void> submitWithSugestion() async{
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://ruwebservicedev.ufam.edu.br/",
        contentType: "application/json",
      ),
    );

    final token = await TokenRepository().getToken();

    print(token);

    dio.options.headers['Authorization'] = 'Bearer $token';
    print({"idCardapio": idCardapio, "avaliacoes": [
      {"tipoAvaliacaoItem": "1", "statusAvaliacaoItem": returnValor(_foodRating.value).toString()},
      {"tipoAvaliacaoItem": "2", "statusAvaliacaoItem": returnValor(_serviceRating.value).toString()}
    ]});

    print("Na sugestão");

    try{
      Response response = await dio.post("v1/avaliacao", data: {"idCardapio": idCardapio, "sugestao": _textController.value, "avaliacoes": [
        {"tipoAvaliacaoItem": "1", "statusAvaliacaoItem": returnValor(_foodRating.value).toString()},
        {"tipoAvaliacaoItem": "2", "statusAvaliacaoItem": returnValor(_serviceRating.value).toString()}
      ]});
      print("Avaliou");
    } catch (e) {
      print(e);
    }
  }

  int returnValor(String av) {
    if(av == "Ótimo") {
      return 5;
    } else if(av == "Bom") {
      return 4;
    } else if(av == "Regular") {
      return 3;
    } else if(av == "Ruim") {
      return 2;
    } else {
      return 1;
    }
  }


  final _titleController = BehaviorSubject<String>();
  final _textController = BehaviorSubject<String>();

  Stream<String> get outTitle => _titleController.stream.transform(validateTitle);
  Stream<String> get outText => _textController.stream.transform(validateText);
  Stream<bool> get outFilled2 => Rx.combineLatest2(outTitle, outText, (a, b) => true);

  Function(String) get changeTitle => _titleController.sink.add;
  Function(String) get changeText => _textController.sink.add;

  @override
  void dispose() {
    _foodRating.close();
    _serviceRating.close();
    super.dispose();
  }

}
