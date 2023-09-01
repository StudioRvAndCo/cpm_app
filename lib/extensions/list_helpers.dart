import 'package:cpm/models/episode/episode.dart';

import '../models/base_model.dart';
import '../models/project/link.dart';
import '../models/sequence/sequence.dart';
import '../models/shot/shot.dart';

extension ListHelpers<T> on List<T> {
  void move(int from, int to) {
    RangeError.checkValidIndex(from, this, "from", length);
    RangeError.checkValidIndex(to, this, "to", length);
    var element = this[from];
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
      if (element.index != null && element.index! >= maxIndex) {
        maxIndex = element.index!;
      }
    });

    return maxIndex + 1;
  }
}
