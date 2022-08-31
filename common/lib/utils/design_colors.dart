import 'package:common/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class DesignColor {
  Color auto(WidgetRef ref);

  const DesignColor();
}

class SolidColor extends DesignColor {
  final Color generic;

  const SolidColor(this.generic);

  @override
  Color auto(WidgetRef ref) {
    return generic;
  }
}

class DayNightColor extends DesignColor {
  final Color light;
  final Color dark;

  const DayNightColor(this.light, this.dark);

  @override
  Color auto(WidgetRef ref) {
    int darkMode = ref.watch(globalDarkModeProvider);
    switch (darkMode) {
      case DARK_MODE_LIGHT:
        return light;
      case DARK_MODE_DARK:
        return dark;
      case DARK_MODE_SYSTEM:
      default:
        Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
        return brightness == Brightness.light ? light : dark;
    }
  }
}

DesignColors designColors = DesignColors._internal();

class DesignColors {
  /// 背景
  late final DayNightColor background;

  /// 功能颜色/白色背景
  late final DayNightColor light_00;

  /// 功能颜色/背景色
  late final DayNightColor light_01;

  /// 文本颜色/解释文本
  late final DayNightColor light_02;

  /// 下划线
  late final DayNightColor light_03;

  /// 文本颜色/标题
  late final DayNightColor dark_01;

  /// 文本颜色/主要文本
  late final DayNightColor dark_02;

  /// 文本颜色/次要文本
  late final DayNightColor dark_03;

  /// 其他颜色/蓝色
  late final DayNightColor blue;

  /// 其他颜色/绿色
  late final DayNightColor green;

  DesignColors._internal() {
    background = const DayNightColor(Color(0xFFF5F5F5), Color(0xFF101010));
    light_00 = const DayNightColor(Color(0xFFFFFFFF), Color(0xFF151515));
    light_01 = const DayNightColor(Color(0xFFF7F7F7), Color(0xFF212121));
    light_02 = const DayNightColor(Color(0xFFCCCCCC), Color(0xFFFAFAFA));
    light_03 = const DayNightColor(Color(0xFFE1E1E1), Color(0xFF212121));
    dark_01 = const DayNightColor(Color(0xFF111111), Color(0xFFFBFBFB));
    dark_02 = const DayNightColor(Color(0xFF666666), Color(0xFFEAEAEA));
    dark_03 = const DayNightColor(Color(0xFF999999), Color(0xFF6F6F6F));
    blue = const DayNightColor(Color(0xFF007FFF), Color(0xB3007FFF));
    green = const DayNightColor(Color(0xFF4ECB77), Color(0xB34ECB77));
  }
}
