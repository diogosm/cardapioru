import 'dart:async';

mixin SuggestionValidator {

  final validateTitle = StreamTransformer<String,String>.fromHandlers(handleData: (title,sink) {
    if(title.isNotEmpty) {
      sink.add(title);
    } else {
      sink.addError("Preencha o título");
    }
  });

  final validateText = StreamTransformer<String,String>.fromHandlers(handleData: (text,sink) {
    if(text.isNotEmpty) {
      sink.add(text);
    } else {
      sink.addError("Escreva a sugestão");
    }
  });

}