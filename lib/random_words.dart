import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('WordPair Generator')
    ),
    body: _buildList()
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, item) {
        if(item.isOdd) return Divider();

        final index = item ~/ 2;

        if(index >= _randomWordPairs.length) {
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);

    return ListTile(
        title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0),),
        trailing: Icon(
          Icons.favorite,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          _handleTapIcon(alreadySaved, pair);
        },
    );
  }

  void _handleTapIcon(bool alreadySaved, pair) {
    setState(() {
      if(alreadySaved) {
        _savedWordPairs.remove(pair);
      } else {
        _savedWordPairs.add(pair);
      }
    });
  }
}