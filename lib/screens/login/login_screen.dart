import 'package:ESPP_Rewards_App_Portador/blocs/login_block.dart';
import 'package:ESPP_Rewards_App_Portador/screens/home/home_screen.dart';

import 'package:flutter/material.dart';
import './input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _document = TextEditingController();
  final _password = TextEditingController();
  final _loginBloc = LoginBloc();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((state) {
      if (state == LoginState.SUCCESS) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (state == LoginState.FAIL) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            "Login e/ou Senha inválidos.",
          ),
          duration: Duration(seconds: 4),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.topCenter,
        color: Colors.indigo[900],
        child: Stack(
          children: [
            StreamBuilder(
              stream: _loginBloc.outState,
              initialData: LoginState.LOADING,
              builder: (context, snapshot) {
                // print(snapshot.data);
                if (snapshot.data == LoginState.LOADING) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Form(
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
                          stream: _loginBloc.outDocument,
                          onChanged: _loginBloc.changeDocument,
                        ),
                        Divider(),
                        InputField(
                          label: 'Senha',
                          controller: _password,
                          stream: _loginBloc.outPassword,
                          isPassword: true,
                          onChanged: _loginBloc.changePassword,
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
                          stream: _loginBloc.outSubmitValid,
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
                              onPressed: snapshot.hasData ? _loginBloc.submit : null,
                              disabledColor: Colors.blue[300].withAlpha(120),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
