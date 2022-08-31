import 'dart:async';
import 'dart:ui';

import 'package:common/global.dart';
import 'package:common/utils/design_colors.dart';
import 'package:common/utils/preferences.dart';
import 'package:demo/global.dart';
import 'package:demo/ui/pages/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Launcher {
  Future<void> prepare() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initUtils();
  }

  void enableImmersiveMode() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  Future<void> _initUtils() async {
    await _initSyncUtils();
    _initASyncUtils();
  }

  ///需要同步初始化的工具类
  Future<void> _initSyncUtils() async {
    await preferences.init();
  }

  ///不需要同步初始化的工具类
  void _initASyncUtils() {}
}

class NgaApp extends ConsumerStatefulWidget {
  const NgaApp({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _NgaAppState();
}

class _NgaAppState extends ConsumerState<NgaApp> with WidgetsBindingObserver {
  late Brightness brightness;
  String? data;

  @override
  void initState() {
    super.initState();
    SingletonFlutterWindow window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged = () {
      WidgetsBinding.instance.handlePlatformBrightnessChanged();
      // This callback is called every time the brightness changes.
      setState(() {
        // 强制build
        brightness = window.platformBrightness;
      });
    };
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String string = await DefaultAssetBundle.of(context).loadString("assets/data.json");
      setState(() {
        data = string;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // var oldThemeData = ThemeData(
    //     primarySwatch: Colors.blue,
    //     appBarTheme: const AppBarTheme(
    //       backgroundColor: Colors.white,
    //       titleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
    //       actionsIconTheme: IconThemeData(color: Colors.black),
    //       iconTheme: IconThemeData(color: Colors.black),
    //       // shadowColor: Colors.transparent,
    //     ));
    int darkMode = ref.watch(globalDarkModeProvider);
    Locale? appLocale = ref.watch(globalLocaleProvider);
    debugPrint("appLocale=${appLocale?.languageCode}");
    brightness = SchedulerBinding.instance.window.platformBrightness;
    debugPrint("DesignColor brightness=$brightness");
    var themeData = ThemeData(
        primaryColor: designColors.background.auto(ref),
        backgroundColor: designColors.light_00.auto(ref),
        dialogBackgroundColor: designColors.light_00.auto(ref),
        scaffoldBackgroundColor: designColors.light_00.auto(ref),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: designColors.light_00.auto(ref),
          titleTextStyle: TextStyle(color: designColors.dark_01.auto(ref), fontSize: 18),
          actionsIconTheme: IconThemeData(color: designColors.dark_01.auto(ref)),
          iconTheme: IconThemeData(color: designColors.dark_01.auto(ref)),

          foregroundColor: designColors.dark_01.auto(ref),
          toolbarTextStyle: TextStyle(color: designColors.dark_01.auto(ref), fontWeight: FontWeight.bold, fontSize: 18),
          // shadowColor: Colors.transparent,
        ),
        listTileTheme: ListTileThemeData(textColor: designColors.dark_01.auto(ref)),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: designColors.light_00.auto(ref),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        }),
        dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: designColors.dark_01.auto(ref),
            ),
            contentTextStyle: TextStyle(
              color: designColors.dark_01.auto(ref),
              fontSize: 16,
            )),
        checkboxTheme: CheckboxThemeData(
            checkColor: MaterialStateProperty.all(designColors.light_01.auto(ref)),
            fillColor: MaterialStateProperty.all(designColors.dark_01.auto(ref)),
            side: BorderSide(color: designColors.dark_01.auto(ref), width: 1),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            )),
        tabBarTheme: TabBarTheme(
            labelPadding: EdgeInsets.symmetric(horizontal: 8),
            labelStyle: TextStyle(
              color: designColors.dark_01.auto(ref),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              color: designColors.dark_01.auto(ref),
              fontSize: 16,
            ),
            indicatorSize: TabBarIndicatorSize.label,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: designColors.dark_01.auto(ref), width: 2),
            )),
        textButtonTheme: TextButtonThemeData(
            style:
                ButtonStyle(textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, color: designColors.blue.auto(ref), fontWeight: FontWeight.bold)))));
    return MaterialApp(
      theme: themeData,
      // darkTheme: themeData.copyWith(brightness: Brightness.dark),
      themeMode: getThemeMode(darkMode),
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: appLocale,
      localeResolutionCallback: (locale, locales) {
        if (locale != null) {
          for (Locale supportedLocale in locales) {
            if (locale.languageCode == supportedLocale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return locales.first;
      },
      supportedLocales: const [
        Locale('en', ''),
        Locale('zh', ''),
        Locale('ja', ''),
      ],
      title: 'NGA',
      // home: HomeScreen(),
      home: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : HomeScreen(jsonString: data!),
      // debugShowCheckedModeBanner: false,
      builder: (context, child) {
        globalLocalizations = AppLocalizations.of(context)!;
        return Scaffold(
          body: child!,
        );
      },
    );
  }

  ThemeMode getThemeMode(int darkModeValue) {
    switch (darkModeValue) {
      case DARK_MODE_LIGHT:
        return ThemeMode.light;
      case DARK_MODE_DARK:
        return ThemeMode.dark;
      case DARK_MODE_SYSTEM:
      default:
        return ThemeMode.system;
    }
  }
}
