import 'package:flutter/material.dart';
import 'services/localization_service.dart';
import 'tabs/data_collection_tab.dart';
import 'tabs/info_analysis_tab.dart';
import 'tabs/patient_management_tab.dart';
import 'tabs/post_event_tab.dart';
import 'tabs/home_page.dart';
import 'pageList/contact_us_page.dart';
import 'pageList/about_us.dart';
import 'pageList/login.dart'; // Import LoginPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalizationService.load('en'); // Default language
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(), // Set LoginPage as the initial screen
  ));
}

class EmergencyDocumentationApp extends StatelessWidget {
  const EmergencyDocumentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeTab();
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  String _currentLanguage = 'en';

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _switchLanguage(String languageCode) async {
    await LocalizationService.load(languageCode);
    setState(() {
      _currentLanguage = languageCode;
    });
  }

  late List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      HomePage(onTabChange: _changeTab),
      const DataCollectionTab(),
      const InfoAnalysisTab(),
      const PatientManagementTab(),
      const PostEventTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final tabTitles = [
      LocalizationService.translate('home'),
      LocalizationService.translate('dataCollection'),
      LocalizationService.translate('infoAnalysis'),
      LocalizationService.translate('patientManagement'),
      LocalizationService.translate('postEvent'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(tabTitles[_currentIndex]),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              _switchLanguage(_currentLanguage == 'en' ? 'he' : 'en');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.deepOrange),
              child: Text(
                LocalizationService.translate('navigation'),
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(LocalizationService.translate('home')),
              onTap: () {
                _changeTab(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.alternate_email),
              title: Text(LocalizationService.translate('contactUs')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_page),
              title: Text(LocalizationService.translate('aboutUs')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: LocalizationService.translate('home'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.collections),
            label: LocalizationService.translate('dataCollection'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.analytics_outlined),
            label: LocalizationService.translate('infoAnalysis'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: LocalizationService.translate('patientManagement'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.note),
            label: LocalizationService.translate('postEvent'),
          ),
        ],
        onTap: _changeTab,
      ),
    );
  }
}
