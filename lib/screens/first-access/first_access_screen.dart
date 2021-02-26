import 'package:ESPP_Rewards_App_Portador/blocs/authentication_bloc.dart';
import 'package:ESPP_Rewards_App_Portador/blocs/first_access_bloc.dart';
import 'package:ESPP_Rewards_App_Portador/screens/first-access/first_access_input.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class FirstAccessScreen extends StatelessWidget {
  final firstAccessBloc = BlocProvider.getBloc<FirstAccessBloc>();
  final authBloc = BlocProvider.getBloc<AuthenticationBloc>();
  final _formKey = GlobalKey<FormState>();

  final cpfController = TextEditingController();
  final nomeController = TextEditingController();
  final nascimentoController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmeSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Primeiro Acesso')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Builder(
          builder: (context) {
            firstAccessBloc.outState.listen(
              (state) {
                if (state == 'errorPass') {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('As senhas não conferem, corrija e tente novamente'),
                    ), // SnackBar
                  );
                }
                if (state == 'error') {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Dados inválidos, corrija e tente novamente'),
                    ), // SnackBar
                  );
                }
                if (state == 'success') {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    text: "Cadastro realizado com sucesso!!! Agora basta acessar com seu CPF e senha",
                    title: 'Cadastro Portador',
                    backgroundColor: Colors.white,
                    confirmBtnColor: Colors.indigo[900],
                    onConfirmBtnTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  );
                }
              },
            );

            return StreamBuilder(
              stream: firstAccessBloc.outState,
              builder: (context, snapshot) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Preencha os campos com seus dados para ativação de seu cadastro',
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
                        controller: cpfController,
                        label: 'CPF',
                        type: 'cpf',
                        validators: (text) {
                          if (text.length < 14)
                            return 'Insira um CPF válido';
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 20),
                      FirstAccessInput(
                        controller: nomeController,
                        label: 'Nome Completo',
                        type: 'nome',
                        validators: (text) {
                          if (text.length < 3)
                            return 'Insira um nome válido';
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 20),
                      FirstAccessInput(
                        controller: nascimentoController,
                        label: 'Data de Nascimento',
                        type: 'nascimento',
                        validators: (text) {
                          if (text.isEmpty || text.length < 10)
                            return 'Insira uma data de nascimento válida';
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 20),
                      FirstAccessInput(
                        controller: senhaController,
                        label: 'Digite sua senha',
                        type: 'senha',
                        validators: (text) {
                          if (text.length < 4)
                            return 'Insira uma senha válida';
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 20),
                      FirstAccessInput(
                        controller: confirmeSenhaController,
                        label: 'Confirme sua senha',
                        type: 'senha',
                        validators: (text) {
                          if (text.length < 4)
                            return 'Insira uma senha válida';
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        color: Colors.indigo[900],
                        child: Builder(
                          builder: (context) {
                            if (snapshot.data == 'loading') {
                              return Row(
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
                              );
                            }
                            return Text(
                              'Criar Conta',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            );
                          },
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        textColor: Colors.white,
                        onPressed: () {
                          if (_formKey.currentState.validate() && snapshot.data != 'loading') {
                            firstAccessBloc.firstAccessValidate(
                              cpf: cpfController.text,
                              nome: nomeController.text,
                              nascimento: nascimentoController.text,
                              senha: senhaController.text,
                              confirmeSenha: confirmeSenhaController.text,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
