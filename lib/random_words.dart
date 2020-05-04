import 'package:crashcourse/redux/actions.dart';
import 'package:crashcourse/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'package:flutter_redux/flutter_redux.dart';


class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State {

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: Text('Saved Pairs'),),
            // body: _buildSavedList(),
          );
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('WordPair Generator'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: _pushSaved,
        )
      ],
    ),
    body: StoreConnector<AppState, dynamic>(
      converter: (store) {
        return store.state.wordPairs;
      },
      builder: (BuildContext context, dynamic pairs) {
        return ListView.builder(
          itemCount: pairs.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return _buildRow(pairs[index]);
          }
        );
      },
    )
    );
  }

  Widget _buildRow(WordPair pair) {
    return StoreConnector<AppState, dynamic>(
      converter: (store) => store,
      builder: (BuildContext context, dynamic store) {
        var alreadySaved = store.state.savedPairs.contains(pair);

        return ListTile(
          title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0),),
          trailing: Icon(
            Icons.favorite,
            color: alreadySaved ? Colors.red : null,
          ),
          onTap: () {
            if (!alreadySaved) {
              store.dispatch(AddWordAction(word: pair));
            } else {
              store.dispatch(RemoveWordAction(word: pair));
            }
          },
        );
      }
    );
  }
}