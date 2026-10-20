import 'package:flutter/widgets.dart';

abstract final class AppScale {
  static const double _designWidth = 375;
  static const double _designHeight = 812;

  static const double maxTextScaleFactor = 1.3;

  static Size? _size;
  static double _widthScale = 1;
  static double _fontScale = 1;

  static void init(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (size == _size) return;

    final isFirstInit = _size == null;
    _size = size;

    final widthRatio = size.width / _designWidth;
    final heightRatio = size.height / _designHeight;

    _widthScale = widthRatio.clamp(0.85, 1.20).toDouble();
    _fontScale = ((widthRatio + heightRatio) / 2).clamp(0.90, 1.15).toDouble();

    if (!isFirstInit) _rebuildDescendants(context);
  }

  static void _rebuildDescendants(BuildContext context) {
    void rebuild(Element element) {
      element.markNeedsBuild();
      element.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  static double s(num value) => _widthScale * value;

  static double sp(num value) => _fontScale * value;

  static double r(num value) => s(value);

  static SizedBox gh(num value) => SizedBox(height: s(value));

  static SizedBox gw(num value) => SizedBox(width: s(value));

  static EdgeInsets all(num value) => EdgeInsets.all(s(value));

  static EdgeInsets symmetric({num horizontal = 0, num vertical = 0}) {
    return EdgeInsets.symmetric(
      horizontal: s(horizontal),
      vertical: s(vertical),
    );
  }

  static EdgeInsetsDirectional only({
    num start = 0,
    num top = 0,
    num end = 0,
    num bottom = 0,
  }) {
    return EdgeInsetsDirectional.only(
      start: s(start),
      top: s(top),
      end: s(end),
      bottom: s(bottom),
    );
  }

  static BorderRadius radius(num value) => BorderRadius.circular(r(value));
}
