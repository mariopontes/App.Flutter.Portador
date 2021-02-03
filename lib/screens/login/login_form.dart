import 'package:flutter/material.dart';
import './input_field.dart';
import '../../blocs/login_block.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _document = TextEditingController();
  final _password = TextEditingController();

  final _loginBlock = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _loginBlock.outState,
      initialData: LoginState.LOADING,
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.data == LoginState.LOADING) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == LoginState.SUCCESS) {
          return Container();
        }
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(5),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                child: Image.network(
                  'https://portalportadorvcndev.azureedge.net/assets/img/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'Acessar o Portal',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              Text(
                'Preencha os campos com seus dados',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              InputField(
                label: 'Login',
                controller: _document,
                stream: _loginBlock.outDocument,
                onChanged: _loginBlock.changeDocument,
              ),
              Divider(),
              InputField(
                label: 'Senha',
                controller: _password,
                stream: _loginBlock.outPassword,
                isPassword: true,
                onChanged: _loginBlock.changePassword,
              ),
              Divider(),
              Text(
                'A senha deve conter 4 digitos númericos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              Divider(),
              StreamBuilder(
                stream: _loginBlock.outSubmitValid,
                builder: (context, snapshot) {
                  return RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    color: Colors.blue[300],
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    textColor: Colors.white,
                    onPressed: snapshot.hasData ? _loginBlock.submit : null,
                    disabledColor: Colors.blue[300].withAlpha(120),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
