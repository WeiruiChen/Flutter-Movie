import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum StartPageAction { action }

class StartPageActionCreator {
  static Action onAction() {
    return const Action(StartPageAction.action);
  }
}
