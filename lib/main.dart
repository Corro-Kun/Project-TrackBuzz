import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:trackbuzz/core/di/injection_container.dart';
import 'package:trackbuzz/core/setting/locale_notifier.dart';
import 'package:trackbuzz/core/setting/theme_notifier.dart';
import 'package:trackbuzz/core/setting/notification_functions.dart';
import 'package:trackbuzz/features/project/presentation/pages/project_list.dart';
import 'package:trackbuzz/features/report/presentation/pages/project_report.dart';
import 'package:trackbuzz/features/track/presentation/pages/time_tracking.dart';
import 'package:trackbuzz/shared/widgets/navigation_bar.dart';
import 'package:trackbuzz/utils/constants.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeNotifier = ThemeNotifier();
  await themeNotifier.initialize();

  final locate = LocaleNotifier();
  await locate.loadLocale();

  await init();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      handleNotificationAction(response);
    },
  );

  await Permission.notification.request();
  //await [Permission.notification, Permission.storage].request();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeNotifier),
        ChangeNotifierProvider(create: (_) => locate),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final locale = Provider.of<LocaleNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrackBuzz',
      theme: theme.currentTheme,
      locale: locale.locale,
      supportedLocales: const [Locale('en'), Locale('es')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [ProjectList(), TimeTracking(), ProjectReport()],
        ),
        bottomNavigationBar: NavigationBarCustom(
          pageController: _pageController,
        ),
      ),
    );
  }
}
