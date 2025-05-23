import 'package:flutter/material.dart';
import 'package:trackbuzz/features/project/presentation/pages/project_list.dart';
import 'package:trackbuzz/features/track/presentation/time_tracking.dart';
import 'package:trackbuzz/shared/widgets/navigation_bar.dart';
import 'package:trackbuzz/utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrackBuzz',
      theme: appThemeDark,
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [ProjectList(), TimeTracking()],
        ),
        bottomNavigationBar: NavigationBarCustom(
          pageController: _pageController,
        ),
      ),
    );
  }
}
