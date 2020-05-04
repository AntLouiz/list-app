import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:crashcourse/random_words.dart';
import 'package:crashcourse/redux/state.dart';
import 'package:crashcourse/redux/reducer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final appStore = Store<AppState>(
      appReducer,
      initialState: AppState.initialState()
    );

    return StoreProvider(
      store: appStore,
      child: MaterialApp(
        home: RandomWords(),
        theme: ThemeData(
          primaryColor: Colors.green
        ),
      )
    );
  }
}