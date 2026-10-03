import 'package:flutter/material.dart';

final class AppScale {
  AppScale._();

  // Figma design size
  static const double _designWidth = 390;
  static const double _designHeight = 844;

  static double _screenWidth = _designWidth;
  static double _screenHeight = _designHeight;

  static bool _isInitialized = false;

  /// Initialize from MaterialApp builder.
  ///
  /// This will be called again automatically when the screen size,
  /// orientation, or window size changes.
  static void init(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    _screenWidth = size.width;
    _screenHeight = size.height;

    _isInitialized = true;
  }

  /// Provides safe design-size values if AppScale is used
  /// before initialization.
  static void _ensureInitialized() {
    if (_isInitialized) return;

    _screenWidth = _designWidth;
    _screenHeight = _designHeight;
  }

  // ---------------------------------------------------------------------------
  // Screen
  // ---------------------------------------------------------------------------

  static double get screenWidth {
    _ensureInitialized();
    return _screenWidth;
  }

  static double get screenHeight {
    _ensureInitialized();
    return _screenHeight;
  }

  static double get shortestSide {
    _ensureInitialized();

    return _screenWidth < _screenHeight
        ? _screenWidth
        : _screenHeight;
  }

  static bool get isTablet => shortestSide >= 600;

  // ---------------------------------------------------------------------------
  // Scale factors
  // ---------------------------------------------------------------------------

  static double get _widthScale {
    _ensureInitialized();
    return _screenWidth / _designWidth;
  }

  static double get _heightScale {
    _ensureInitialized();
    return _screenHeight / _designHeight;
  }

  // ---------------------------------------------------------------------------
  // General scaling
  // ---------------------------------------------------------------------------

  /// General-purpose scaling.
  ///
  /// Recommended for:
  /// - spacing
  /// - padding
  /// - icon sizes
  /// - component sizes
  ///
  /// Scaling is limited to prevent elements from becoming
  /// excessively small or large.
  static double s(num value) {
    _ensureInitialized();

    final base = value.toDouble();
    final scaled = base * _widthScale;

    return scaled
        .clamp(
      base * 0.85,
      base * 1.20,
    )
        .toDouble();
  }

  /// Font-size scaling with controlled limits.
  static double sp(num value) {
    _ensureInitialized();

    final base = value.toDouble();

    final scale = (_widthScale + _heightScale) / 2;
    final scaled = base * scale;

    return scaled
        .clamp(
      base * 0.90,
      base * 1.15,
    )
        .toDouble();
  }

  /// Pure width-based scaling.
  ///
  /// Use only when the size really needs to depend on screen width.
  static double w(num value) {
    _ensureInitialized();

    return value.toDouble() * _widthScale;
  }

  /// Pure height-based scaling.
  ///
  /// Use only when the size really needs to depend on screen height.
  static double h(num value) {
    _ensureInitialized();

    return value.toDouble() * _heightScale;
  }

  /// Border radius.
  static double r(num value) => s(value);

  // ---------------------------------------------------------------------------
  // Gaps
  // ---------------------------------------------------------------------------

  static SizedBox gh(num value) {
    return SizedBox(
      height: s(value),
    );
  }

  static SizedBox gw(num value) {
    return SizedBox(
      width: s(value),
    );
  }

  // ---------------------------------------------------------------------------
  // Insets
  // ---------------------------------------------------------------------------

  static EdgeInsets all(num value) {
    return EdgeInsets.all(
      s(value),
    );
  }

  static EdgeInsets hOnly(num value) {
    return EdgeInsets.symmetric(
      horizontal: s(value),
    );
  }

  static EdgeInsets vOnly(num value) {
    return EdgeInsets.symmetric(
      vertical: s(value),
    );
  }

  static EdgeInsets symmetric({
    num horizontal = 0,
    num vertical = 0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: s(horizontal),
      vertical: s(vertical),
    );
  }
}