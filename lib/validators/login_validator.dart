import 'dart:async';

mixin LoginValidator {

  final validateCpf = StreamTransformer<String,String>.fromHandlers(handleData: (cpf, sink) {
    if(cpf.length == 14) {
      sink.add(cpf);
    } else {
      sink.addError("Insira um cpf válido");
    }
  });

  final validatePassword = StreamTransformer<String,String>.fromHandlers(handleData: (password, sink) {
    if(password.isNotEmpty) {
      sink.add(password);
    } else {
      sink.addError("Insira a senha");
    }
  });

}