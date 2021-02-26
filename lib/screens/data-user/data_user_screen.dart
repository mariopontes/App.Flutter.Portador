import 'package:ESPP_Rewards_App_Portador/blocs/data_user_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:cool_alert/cool_alert.dart';
import 'data_user_input.dart';

class DataUserScreen extends StatelessWidget {
  final dataUserBloc = BlocProvider.getBloc<DataUserBloc>();

  final emailController = TextEditingController();
  final celularController = TextEditingController();
  final nascimentoController = TextEditingController();

  final senhaController = TextEditingController();
  final novaSenhaController = TextEditingController();
  final confirmacaoNovaSenhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final maskFone = MaskTextInputFormatter(mask: "(##) # ####-####", filter: {"#": RegExp(r'[0-9]')});
  final birthDate = MaskTextInputFormatter(mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Column(
                  children: [
                    Icon(Icons.edit, size: 20),
                    Text('Dados Usuário', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Icon(Icons.vpn_key, size: 20),
                    Text('Senha', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ],
          ),
          title: Text('Alteração Dados de Cadastro'),
        ),
        body: Builder(
          builder: (context) {
            dataUserBloc.outState.listen(
              (state) {
                if (state == 'error') {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(dataUserBloc.messageError),
                    ), // SnackBar
                  );
                }
                if (state == 'success1' || state == 'success2') {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    text: "Operação realizada com sucesso.",
                    title: state == 'success1' ? 'Alteração de Dados' : 'Alteração de Senha',
                    backgroundColor: Colors.white,
                    confirmBtnColor: Colors.indigo[900],
                    onConfirmBtnTap: () {
                      Navigator.pop(context);
                      senhaController.clear();
                      novaSenhaController.clear();
                      confirmacaoNovaSenhaController.clear();
                    },
                  );
                }
              },
            );
            return TabBarView(
              children: [
                SingleChildScrollView(
                  child: FutureBuilder(
                    future: dataUserBloc.getDataUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        emailController.text = snapshot.data.email;
                        celularController.text = snapshot.data.tel2;
                        nascimentoController.text = snapshot.data.birthDate;

                        return Form(
                          key: _formKey,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            margin: EdgeInsets.only(top: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                DataUserInput(
                                    label: 'E-mail',
                                    controller: emailController,
                                    typeInput: 'email',
                                    validators: (text) {
                                      if (text.isEmpty || !text.contains('@') || !text.contains('.'))
                                        return 'Insira um email válido';
                                      else
                                        return null;
                                    }),
                                SizedBox(height: 20),
                                DataUserInput(
                                  label: 'Celular',
                                  controller: celularController,
                                  typeInput: 'celular',
                                  validators: (text) {
                                    if (text.isEmpty || text.length < 16)
                                      return 'Insira um número de celular válido';
                                    else
                                      return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                DataUserInput(
                                  label: 'Data de Nascimento',
                                  controller: nascimentoController,
                                  typeInput: 'nascimento',
                                  validators: (text) {
                                    if (text.isEmpty || text.length < 10)
                                      return 'Data de nascimento inválida';
                                    else
                                      return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  height: 45,
                                  child: RaisedButton(
                                    color: Colors.indigo[900],
                                    textColor: Colors.white,
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        dataUserBloc.updateDataUser(
                                          email: emailController.text,
                                          celular: celularController.text,
                                          nascimento: nascimentoController.text,
                                        );
                                      }
                                    },
                                    child: Text('Alterar'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Container(height: 300, child: Center(child: CircularProgressIndicator(backgroundColor: Colors.black)));
                    },
                  ),
                ),
                SingleChildScrollView(
                  child: Form(
                    key: _formKey2,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DataUserInput(
                              label: 'Senha Atual',
                              controller: senhaController,
                              typeInput: 'senha',
                              validators: (text) {
                                if (text.length < 4)
                                  return 'Senha atual deve conter 4 dígitos.';
                                else
                                  return null;
                              }),
                          SizedBox(height: 20),
                          DataUserInput(
                            label: 'Nova Senha',
                            controller: novaSenhaController,
                            typeInput: 'senha',
                            validators: (text) {
                              if (text.length < 4)
                                return 'A nova senha deve conter 4 dígitos.';
                              else
                                return null;
                            },
                          ),
                          SizedBox(height: 20),
                          DataUserInput(
                            label: 'Confirme a nova Senha',
                            controller: confirmacaoNovaSenhaController,
                            typeInput: 'senha',
                            validators: (text) {
                              if (text.length < 4)
                                return 'Os dados não conferem';
                              else
                                return null;
                            },
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 45,
                            child: RaisedButton(
                              color: Colors.indigo[900],
                              textColor: Colors.white,
                              onPressed: () {
                                if (_formKey2.currentState.validate()) {
                                  dataUserBloc.updatePasswordUser(
                                    senha: senhaController.text,
                                    novaSenha: novaSenhaController.text,
                                    confirmacaoNovaSenha: confirmacaoNovaSenhaController.text,
                                  );
                                }
                              },
                              child: Text('Alterar'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
