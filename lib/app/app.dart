
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:do_an_tong_hop/controller/app_controller.dart';
import 'package:do_an_tong_hop/controller/chat_controller.dart';
import 'package:do_an_tong_hop/controller/posts_controller.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/localization/flutter_localizations_delegate.dart';
import 'package:do_an_tong_hop/screen/no_connection_screen.dart';
import 'package:do_an_tong_hop/screen/splash_screen.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoAnApp extends StatefulWidget {

  @override
  State<DoAnApp> createState() => _AppState();
}

class _AppState extends State<DoAnApp> {
  final AppController appController = Get.put(AppController());
  final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();
  StreamSubscription<ConnectivityResult> connectivitySubscription;

  ConnectivityResult _previousResult;
  @override
  void initState() {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        if (nav.currentState != null) {
          Get.offAll(()=>NoConnectionScreen());
        }
      } else if (_previousResult == ConnectivityResult.none) {
        if (nav.currentState != null) {
          Get.offAll(()=>SplashScreen());
        } else {
          if (nav.currentState != null) {
            Get.offAll(()=>SplashScreen());
          }
        }
      }

      _previousResult = connectivityResult;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    this._fetchLocale().then((locale) {
      appController.locale.value = locale;
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appController.getDefaultLanguage();
    return GetMaterialApp(
        navigatorKey: nav,
        color: AppColors.primary,
        initialBinding: BindingsBuilder(() {
          Get.put(UserController());
          Get.put(ChatController());
          Get.put(PostsController());
        }),
        debugShowCheckedModeBanner: false,
        title: '',
        supportedLocales: [
          Locale('vi', 'VN'),
          Locale('en', 'US'),
        ],
        locale: appController.locale.value,
        localizationsDelegates: [
          FlutterLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback:
            (Locale locale, Iterable<Locale> supportedLocales) {
          if (locale == null) {
            return supportedLocales.first;
          }else{
            for (Locale supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode ||
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
          }
          return supportedLocales.first;
        },
        theme: ThemeData.light().copyWith(
            primaryColor: Colors.white,
            accentColor: Colors.black,
            accentColorBrightness: Brightness.dark,
            toggleableActiveColor: Colors.blue[900],
            bottomAppBarColor: Colors.white,
            appBarTheme: AppBarTheme(
                brightness: Brightness.light,
                elevation: 1
            ),
            primaryColorBrightness: Brightness.light,
            primaryColorDark: Colors.black87,
            primaryIconTheme: IconThemeData(
                color: Colors.black
            ),
            brightness: Brightness.light,
            cardColor: Colors.white,
            backgroundColor: Colors.grey[200],
            dialogBackgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.light(
                onPrimary: Colors.black
            ),
            primaryTextTheme: GoogleFonts.latoTextTheme(ThemeData.light().textTheme),
            accentTextTheme: GoogleFonts.latoTextTheme(ThemeData.light().accentTextTheme),
            textTheme: GoogleFonts.latoTextTheme(ThemeData.light().textTheme.copyWith(
                caption: ThemeData.light().textTheme.caption.copyWith(
                    color: Colors.black54,
                    fontSize: 10,
                    fontWeight: FontWeight.w500
                ),
                bodyText2:  ThemeData.light().textTheme.bodyText2.copyWith(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold
                ),
                bodyText1:  ThemeData.light().textTheme.bodyText1.copyWith(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w400
                )
            ))
        ),
        darkTheme: ThemeData.dark().copyWith(
            primaryColor: Colors.black,
            accentColor: Colors.white,
            accentColorBrightness: Brightness.light,
            toggleableActiveColor: Colors.blue[900],
            bottomAppBarColor: Colors.black87,
            cardColor: Color(0xFF121212),
            backgroundColor: Colors.black54,
            dialogBackgroundColor: Color(0xFF121212),
            scaffoldBackgroundColor: Color(0xFF121212),
            colorScheme: ColorScheme.dark(
                onPrimary: Colors.white,
                surface: Colors.black
            ),
            canvasColor: Colors.black,
            primaryTextTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme),
            accentTextTheme: GoogleFonts.latoTextTheme(ThemeData.dark().accentTextTheme),
            textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme.copyWith(
                caption: ThemeData.dark().textTheme.caption.copyWith(
                    color: Colors.white54,
                    fontSize: 10,
                    fontWeight: FontWeight.w500
                ),
                bodyText2:  ThemeData.dark().textTheme.bodyText2.copyWith(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold
                ),
                bodyText1:  ThemeData.dark().textTheme.bodyText1.copyWith(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400
                )
            ))
        ),
        themeMode: ThemeMode.light,
        home: SplashScreen());
  }

  _fetchLocale() async {
    Locale tempLocale;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = (prefs.getString('languageCode') ?? 'en');

    switch (languageCode) {
      case 'ENGLISH':
        tempLocale = Locale('ENGLISH', 'US');
        break;
      case 'VIETNAMESE':
        tempLocale = Locale('VIETNAMESE', 'VI');
        break;
      default:
        tempLocale = Locale('ENGLISH', 'US');
    }
    return tempLocale;
  }
}
