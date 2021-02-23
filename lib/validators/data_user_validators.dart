import 'dart:async';

class DataUserValidators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@') && email.contains('.')) {
      sink.add(email);
    } else {
      sink.addError("Insira um email válido");
    }
  });

  final validateCel = StreamTransformer<String, String>.fromHandlers(handleData: (celular, sink) {
    if (celular.length > 10) {
      sink.add(celular);
    } else {
      sink.addError("Insira um número de celular válido");
    }
  });

  final validateBirthDate = StreamTransformer<String, String>.fromHandlers(handleData: (nascimento, sink) {
    if (nascimento.length > 7) {
      sink.add(nascimento);
    } else {
      sink.addError("Insira uma data válida");
    }
  });
}
