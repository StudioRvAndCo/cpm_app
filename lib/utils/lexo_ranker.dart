import 'package:lexo_rank/lexo_rank.dart';

class LexoRanker {
  String get _defaultRank => LexoRank.middle().value;

  String newRank({String? previous, String? next}) {
    if (previous == null && next == null) {
      return _defaultRank;
    } else if (next == null) {
      return LexoRank.parse(previous!).genNext().value;
    } else if (previous == null) {
      return LexoRank.parse(next).genPrev().value;
    } else {
      return LexoRank.parse(previous).between(LexoRank.parse(next)).value;
    }
  }
}
