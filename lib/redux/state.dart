import 'package:english_words/english_words.dart';
import 'package:meta/meta.dart';

class AppState {
  List<WordPair> wordPairs = [];
  Set<WordPair> savedPairs = Set<WordPair>();

  AppState({ @required this.wordPairs, @required this.savedPairs});

  factory AppState.initialState() {
    List<WordPair> initialPairs = [];
    
    initialPairs.addAll(generateWordPairs().take(10));

    return AppState(
      wordPairs: initialPairs,
      savedPairs: Set<WordPair>()
    );
  }

  AppState addWord(WordPair word) {
    savedPairs.add(word);
    print(savedPairs);

    return AppState(
      wordPairs: wordPairs,
      savedPairs: savedPairs
    );
  }

  AppState removeWord(WordPair word) {
    savedPairs.remove(word);

    return AppState(
      wordPairs: wordPairs,
      savedPairs: savedPairs
    );
  }
}