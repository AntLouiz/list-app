import 'package:crashcourse/redux/actions.dart';
import 'package:crashcourse/redux/state.dart';
import './actions.dart';


AppState appReducer(AppState state, dynamic action) {
  if (action is AddWordAction) {
    return state.addWord(action.word);
  } else if (action is RemoveWordAction) {
    return state.removeWord(action.word);
  } else {
    return state;
  }
}