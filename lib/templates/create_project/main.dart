import 'dart:async';

import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:toastification/toastification.dart';
import 'presentation/core/generated/i18n/translations.g.dart';

import 'data/services/network_service/base_network_service/interceptors/request_interceptor.dart';
import 'data/util/di/data_dependecies_injection.dart';
import 'presentation/core/config/dart_define_config.dart';
import 'presentation/core/theme/app_theme.dart';
import 'presentation/core/util/logger_util.dart';
import 'presentation/core/widgets/fl_responsive/fl_responsive.dart';
import 'presentation/flavor/flavor.dart';
import 'presentation/module/example/example_screen.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await DataDependenciesInjection.inject();
      await Flavor.initialize(DartDefineConfig.environment);
      LoggerUtil.setErrorsLog();

      // Initialze Chukker Interceptor
      final dioRequestInspector = DioRequestInspector(
        isDebugMode: true,
        // ignore: deprecated_member_use
        showFloating: false,
      );
      setRequestInspector(requestInspector: dioRequestInspector);

      final appWithInspector = DioRequestInspectorMain(inspector: dioRequestInspector, child: const MyApp());

      // Slang
      LocaleSettings.useDeviceLocale();
      final appWithSlang = TranslationProvider(child: appWithInspector);

      runApp(appWithSlang);
    }, 
    (error, stackTrace) {}
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Flutter Demo',
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        navigatorObservers: [
          DioRequestInspector.navigatorObserver,
        ],
        initialRoute: "/",
        builder: (context, child) {
          return FLResponsive(
            builder: (context, orientation, screenType) {
              return child!;
            }
          );
        },
        home: const ExampleScreen(),
      ),
    );
  }
}
