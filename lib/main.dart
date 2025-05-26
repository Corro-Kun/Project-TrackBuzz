import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackbuzz/core/setting/theme_notifier.dart';
import 'package:trackbuzz/features/project/presentation/pages/project_list.dart';
import 'package:trackbuzz/features/report/presentation/pages/project_report.dart';
import 'package:trackbuzz/features/track/presentation/pages/time_tracking.dart';
import 'package:trackbuzz/shared/widgets/navigation_bar.dart';
import 'package:trackbuzz/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeNotifier = ThemeNotifier();
  await themeNotifier.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => themeNotifier,
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrackBuzz',
      theme: theme.currentTheme,
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
