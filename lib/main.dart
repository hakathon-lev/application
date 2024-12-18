import 'package:flutter/material.dart';
import 'tabs/data_collection_tab.dart';
import 'tabs/info_analysis_tab.dart';
import 'tabs/patient_management_tab.dart';
import 'tabs/post_event_tab.dart';
import 'tabs/home_page.dart';
import 'pageList/contact_us_page.dart';
import 'pageList/about_us.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: EmergencyDocumentationApp(),
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

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
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

  final List<String> _tabTitles = [
    'Home',
    'Data Collection',
    'Information Analysis',
    'Patient Management',
    'Post-Event',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabTitles[_currentIndex]),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrange),
              child: Text(
                'Navigation',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                _changeTab(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.alternate_email),
              title: const Text('Contact Us'),
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
              title: const Text('About Us'),
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            label: 'Data Collection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'Info Analysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Patient Mgmt',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Post-Event',
          ),
        ],
        onTap: _changeTab,
      ),
    );
  }
}
