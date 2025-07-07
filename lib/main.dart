import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/analysis_provider.dart';
import 'screens/home_screen.dart';
import 'screens/analysis_screen.dart';
import 'services/database_service.dart';
import 'services/gemini_service.dart';
import 'config/api_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.instance.initDatabase();

  // Initialize Gemini service with API key
  GeminiService.initialize(ApiConfig.getGeminiApiKey());

  runApp(const MysticWhisperApp());
}

class MysticWhisperApp extends StatelessWidget {
  const MysticWhisperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AnalysisProvider()),
      ],
      child: MaterialApp(
        title: 'Mystic Whisper',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF6C63FF),
            secondary: Color(0xFF03DAC6),
            surface: Color(0xFF1E1E1E),
            background: Color(0xFF121212),
            onPrimary: Colors.white,
            onSecondary: Colors.black,
            onSurface: Colors.white,
            onBackground: Colors.white,
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: const [
            HomeScreen(),
            AnalysisScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.9),
              ],
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _tabController.index,
            onTap: (index) => _tabController.animateTo(index),
            backgroundColor: Colors.transparent,
            selectedItemColor: const Color(0xFF6C63FF),
            unselectedItemColor: Colors.grey[400],
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined),
                activeIcon: Icon(Icons.analytics),
                label: 'Analyze',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
