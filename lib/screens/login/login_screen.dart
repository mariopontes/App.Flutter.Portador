import 'package:flutter/material.dart';

import '../../blocs/authentication_bloc.dart';
import '../../screens/home/home_screen.dart';
import './input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _document = TextEditingController();
  final _password = TextEditingController();
  final authBloc = AuthenticationBloc();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    authBloc.outState.listen(
      (state) {
        if (state == AuthState.SUCCESS) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
        } else if (state == AuthState.FAIL) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
              "Login e/ou Senha inválidos.",
            ),
            duration: Duration(seconds: 4),
          ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeDataColor = Theme.of(context).accentColor;

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.topCenter,
        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: [
            StreamBuilder(
              stream: authBloc.outState,
              initialData: AuthState.IDLE,
              builder: (context, snapshot) {
                if (snapshot.data == AuthState.LOADING) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Form(
                    child: ListView(
                      padding: EdgeInsets.all(5),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 75, vertical: 50),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'Portal do Portador',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            color: themeDataColor,
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
                            color: themeDataColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(),
                        InputField(
                          label: 'Login',
                          controller: _document,
                          stream: authBloc.outDocument,
                          onChanged: authBloc.changeDocument,
                        ),
                        Divider(),
                        InputField(
                          label: 'Senha',
                          controller: _password,
                          stream: authBloc.outPassword,
                          isPassword: true,
                          onChanged: authBloc.changePassword,
                        ),
                        Divider(),
                        Text(
                          'A senha deve conter 4 digitos númericos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            color: themeDataColor,
                          ),
                        ),
                        Divider(),
                        StreamBuilder(
                          stream: authBloc.outSubmitValid,
                          builder: (context, snapshot) {
                            return RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              color: Colors.blue[300],
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              textColor: themeDataColor,
                              onPressed: snapshot.hasData ? authBloc.signIn : null,
                              disabledColor: Colors.blue[300].withAlpha(120),
                            );
                          },
                        ),
                        Divider(),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          color: Colors.indigo[900],
                          child: Text(
                            'Primeiro Acesso',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.white),
                          ),
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/primeiro-acesso');
                          },
                        ),
                        Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Esqueceu a senha?  ', style: TextStyle(color: Colors.white, fontSize: 15)),
                            GestureDetector(
                              onTap: () => {Navigator.pushNamed(context, '/esqueci-senha')},
                              child: Text('Clique aqui', style: TextStyle(color: Colors.lightGreen, fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                          ],
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
