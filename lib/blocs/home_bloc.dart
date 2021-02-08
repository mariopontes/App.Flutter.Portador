import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

enum BlockState { Home, TermosOfUse, Extrat, ChangePassword, ChangeUserData, SignOut }

class HomeBloc extends BlocBase {
  final stateController = BehaviorSubject<BlockState>();
  Stream<BlockState> get outState => stateController.stream;

  void setScreen(String screen) {
    if (screen == 'TermosOfUse') stateController.add(BlockState.TermosOfUse);
    if (screen == 'ChangeUserData') stateController.add(BlockState.ChangeUserData);
    if (screen == 'ChangePassword') stateController.add(BlockState.ChangePassword);
    if (screen == 'Extrat') stateController.add(BlockState.Extrat);
    if (screen == 'Sair') stateController.add(BlockState.SignOut);

    stateController.add(BlockState.Home);
  }

  @override
  void dispose() {
    super.dispose();
    stateController.close();
  }
}
