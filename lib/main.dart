import 'package:coop_cards_poc/models/base_model.dart';
import 'package:coop_cards_poc/utils/consts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'pages/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(ChangeNotifierProvider(
      builder: (context) => BaseModel(),
      child: EasyLocalization(child: MyApp()),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var langData = EasyLocalizationProvider.of(context).data;
    const LANG_PATH = 'assets/langs';
    const EN = 'en';
    const ES = 'es';
    const US = 'US';
    const FONT_FAMILY = 'Montserrat';

    return EasyLocalizationProvider(
      data: langData,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          //app-specific localization
          EasylocaLizationDelegate(locale: langData.locale, path: LANG_PATH),
        ],
        title: 'Coop POC',
        supportedLocales: [Locale(EN, US), Locale(ES, US)],
        locale: langData.savedLocale,
        theme: ThemeData(
          fontFamily: FONT_FAMILY,
          primaryColor: Consts.mainColor,
        ),
        home: Center(child: Center(child: Login())),
      ),
    );
  }
}
