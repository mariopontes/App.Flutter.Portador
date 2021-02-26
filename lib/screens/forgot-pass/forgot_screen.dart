import 'package:ESPP_Rewards_App_Portador/blocs/forgot_pass_bloc.dart';
import 'package:ESPP_Rewards_App_Portador/screens/first-access/first_access_input.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatelessWidget {
  final forgotPassBloc = BlocProvider.getBloc<ForgotPassBloc>();

  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Redefina sua senha')),
      body: Builder(
        builder: (context) {
          forgotPassBloc.outState.listen(
            (state) {
              if (state == 'error') {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(forgotPassBloc.messageError),
                  ), // SnackBar
                );
              }

              if (state == 'success') {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  title: 'Token enviado com sucesso',
                  text: "Enviamos instruções no seu e-mail de como redefinir sua senha",
                  confirmBtnColor: Colors.indigo[900],
                  backgroundColor: Colors.white,
                  onConfirmBtnTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                );
              }
            },
          );

          return SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Insira seu e-mail e enviaremos um token de acesso',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.indigo[900],
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  FirstAccessInput(
                    controller: emailController,
                    label: 'E-mail',
                    type: 'email',
                    validators: (text) {
                      if (text.length < 10 || !text.contains('@') || !text.contains('.'))
                        return 'Insira um e-mail válido';
                      else
                        return null;
                    },
                  ),
                  SizedBox(height: 20),
                  StreamBuilder(
                    stream: forgotPassBloc.outState,
                    builder: (context, snapshot) {
                      if (snapshot.data == 'loading') {
                        return RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          color: Colors.indigo[900],
                          textColor: Colors.white,
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Text(
                                  'Aguarde...',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ],
                          ),
                        );
                      }

                      return RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        color: Colors.indigo[900],
                        child: Text(
                          'Enviar token',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        textColor: Colors.white,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            forgotPassBloc.sendEmail(email: emailController.text);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
