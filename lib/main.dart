import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomWords(),
      theme: ThemeData(
        primaryColor: Colors.green
      ),
    );
  }

}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State {
  final _randomWordPairs = <WordPair>[];

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
    return ListTile(title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0),),);
  }
}