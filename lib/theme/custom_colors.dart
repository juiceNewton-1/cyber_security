import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color green;
  final Color yellow;
  final Color red;
  final Color dot;
  final Color disabled;
  final Color dateColor;

  const CustomColors({
    required this.green,
    required this.yellow,
    required this.red,
    required this.dot,
    required this.disabled,
    required this.dateColor,
  });

  @override
  CustomColors copyWith({
    Color? green,
    Color? yellow,
    Color? red,
    Color? dot,
    Color? disabled,
    Color? dateColor,
  }) {
    return CustomColors(
      green: green ?? this.green,
      yellow: yellow ?? this.yellow,
      red: red ?? this.red,
      dot: dot ?? this.dot,
      disabled: disabled ?? this.disabled,
      dateColor: dateColor ?? this.dateColor,
    );
  }

  static const customColors = CustomColors(
    green: Color(0xFF46C532),
    yellow: Color(0xFFFFA406),
    red: Color(0xFFF63A21),
    dot: Color(0xFF99999980),
    disabled: Color(0xFFBFBFBF),
    dateColor: Color(0xFFC9C9C9),
  );

  @override
  ThemeExtension<CustomColors> lerp(
      covariant ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      green: Color.lerp(green, other.green, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      red: Color.lerp(red, other.red, t)!,
      dot: Color.lerp(dot, other.dot, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      dateColor: Color.lerp(dateColor, other.dateColor, t)!,
    );
  }
}
