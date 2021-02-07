import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

enum BlockState { Home, TermosOfUse, Extrat, ChangePassword, ChangeUserData }

class HomeBloc extends BlocBase {
  final stateController = BehaviorSubject<BlockState>();
  Stream<BlockState> get outState => stateController.stream;

  void setScreen(String screen) {
    if (screen == 'TermosOfUse') {
      stateController.add(BlockState.TermosOfUse);
    }

    Future.delayed(Duration(seconds: 0), () => stateController.add(BlockState.Home));
  }

  @override
  void dispose() {
    super.dispose();
    stateController.close();
  }
}
