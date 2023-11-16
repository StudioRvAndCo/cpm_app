import 'package:cpm/models/base_model.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/project/link/link.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/models/shot/shot.dart';

extension ListExtensions<T> on List<T> {
  void move(int from, int to) {
    RangeError.checkValidIndex(from, this, "from", length);
    RangeError.checkValidIndex(to, this, "to", length);

    final element = this[from];
    if (from < to) {
      setRange(from, to, this, from + 1);
    } else {
      setRange(to + 1, from + 1, this, to);
    }
    this[to] = element;
  }

  int getNextIndex<Model extends BaseModel>() {
    assert(Model == Link || Model == Episode || Model == Sequence || Model == Shot);

    if (length == 0) {
      return 1;
    }

    int maxIndex = 1;
    forEach((dynamic element) {
      // ignore: avoid_dynamic_calls
      if (element.index != null && element.index! as int >= maxIndex) {
        // ignore: avoid_dynamic_calls
        maxIndex = element.index! as int;
      }
    });

    return maxIndex + 1;
  }
}
