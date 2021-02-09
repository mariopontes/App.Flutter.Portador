import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

enum BlockState { Home, TermosOfUse, Extrat, ChangePassword, ChangeUserData, SignOut }

class HomeBloc extends BlocBase {
  final _stateController = BehaviorSubject<BlockState>();
  Stream<BlockState> get outState => _stateController.stream;

  final _nameUserController = BehaviorSubject();
  Stream get nameUser => _nameUserController.stream;

  void setScreen(String screen) {
    if (screen == 'TermosOfUse') _stateController.add(BlockState.TermosOfUse);
    if (screen == 'ChangeUserData') _stateController.add(BlockState.ChangeUserData);
    if (screen == 'ChangePassword') _stateController.add(BlockState.ChangePassword);
    if (screen == 'Extrat') _stateController.add(BlockState.Extrat);
    if (screen == 'Sair') _stateController.add(BlockState.SignOut);

    _stateController.add(BlockState.Home);
  }

  void setNameUser(String name) {
    _nameUserController.add(name);
  }

  @override
  void dispose() {
    super.dispose();
    _stateController.close();
    _nameUserController.close();
  }
}
