import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:english_words/english_words.dart';

import 'package:crashcourse/redux/actions.dart';
import 'package:crashcourse/redux/state.dart';

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
            body: StoreConnector<AppState, dynamic>(
              converter: (store) => store.state.savedPairs,
              builder: (BuildContext context, dynamic savedPairs) {
                List<WordPair> savedPairsList = [];
                savedPairsList.addAll(savedPairs);
                return _buildList(savedPairsList);
              },
            ),
          );
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('ListApp'),
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
        return _buildList(pairs);
      },
    )
    );
  }


  Widget _buildList(List<WordPair> pairs) {
    Widget widgedBuilded;

    if (pairs.length > 0) {
      widgedBuilded = ListView.builder(
        itemCount: pairs.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return _buildRow(pairs[index]);
        }
      );
    } else {
      var notFoundMsg = 'Not found any words.';
      widgedBuilded = Container(
        child: Center(
          child: Text(notFoundMsg, style: TextStyle(fontSize: 20.0)),
        ),
      );
    }

    return widgedBuilded;
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