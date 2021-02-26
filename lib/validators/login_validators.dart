import 'dart:async';

class LoginValidators {
  final validateDocument = StreamTransformer<String, String>.fromHandlers(handleData: (document, sink) {
    if (document.length > 12) {
      sink.add(document);
    } else {
      sink.addError("Insira um CPF válido");
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    if (password.length > 3) {
      sink.add(password);
    } else {
      sink.addError("Senha inválida, deve conter 4 caracteres");
    }
  });
}
