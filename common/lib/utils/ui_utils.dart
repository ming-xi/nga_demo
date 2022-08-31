import 'dart:ui';

import 'package:common/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

bool isDarkMode(WidgetRef ref) {
  int darkMode = ref.watch(globalDarkModeProvider);
  switch (darkMode) {
    case DARK_MODE_LIGHT:
      return false;
    case DARK_MODE_DARK:
      return true;
    case DARK_MODE_SYSTEM:
    default:
      Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness != Brightness.light;
  }
}

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    duration: const Duration(seconds: 2),
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<T?> showNgaSimpleDialog<T>({required BuildContext context, required String text}) {
  return showNgaDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(text),
    ),
  );
}

Future<T?> showNgaDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  Color? barrierColor,
  String barrierLabel = "",
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor ?? Colors.black.withOpacity(0.25),
    barrierLabel: barrierLabel,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    pageBuilder: (ctx, anim1, anim2) => WillPopScope(child: builder(context), onWillPop: () => Future.value(barrierDismissible)),
    transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8 * anim1.value, sigmaY: 8 * anim1.value),
      child: FadeTransition(
        child: child,
        opacity: anim1,
      ),
    ),
  );
}

class NgaIcon extends ConsumerWidget {
  final String assetName;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  const NgaIcon(this.assetName, {this.width, this.height, this.color, this.fit, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (assetName.endsWith(".svg")) {
      return SvgPicture.asset(
        assetName,
        width: width,
        height: height,
        color: color,
        fit: fit ?? BoxFit.contain,
      );
    } else {
      Widget result = Image.asset(
        assetName,
        width: width,
        height: height,
        color: color,
        fit: fit,
      );
      if (isDarkMode(ref)) {
        result = Opacity(
          opacity: globalDarkModeImageOpacity,
          child: result,
        );
      }
      return result;
    }
  }
}
