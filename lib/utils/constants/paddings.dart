import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';

enum Paddings {
  custom(0),
  padding2(2),
  padding4(4),
  padding8(8),
  padding16(16),
  padding32(32),
  padding64(64),
  ;

  double get bottomSystemUiPadding => MediaQuery.of(navigatorKey.currentContext!).padding.bottom;

  double get topSystemUiPadding => MediaQuery.of(navigatorKey.currentContext!).padding.top;

  EdgeInsets get zero => EdgeInsets.zero;

  EdgeInsets get all => EdgeInsets.all(_padding);

  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: _padding);

  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: _padding);

  EdgeInsets get left => EdgeInsets.only(left: _padding);

  EdgeInsets get right => EdgeInsets.only(right: _padding);

  EdgeInsets get top => EdgeInsets.only(top: _padding);

  EdgeInsets get bottom => EdgeInsets.only(bottom: _padding);

  EdgeInsets get fab => const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64);

  EdgeInsets get page => const EdgeInsets.all(16);

  EdgeInsets get pageHorizontal => const EdgeInsets.symmetric(horizontal: 16);

  EdgeInsets get pageVertical => const EdgeInsets.symmetric(vertical: 16);

  EdgeInsets get pageVerticalWithSystemUi => EdgeInsets.only(
        top: 16 + topSystemUiPadding,
        bottom: 16 + bottomSystemUiPadding,
      );

  EdgeInsets get drawer => const EdgeInsets.all(8);

  EdgeInsets get dragHandle => const EdgeInsets.only(right: 24);

  static EdgeInsets withFab(EdgeInsets padding) => padding.copyWith(bottom: kFloatingActionButtonMargin + 64);

  static EdgeInsets withTwoFabs(EdgeInsets padding) => padding.copyWith(bottom: kFloatingActionButtonMargin + 112);

  final double _padding;

  const Paddings(this._padding);
}
