import 'package:flutter/material.dart';
import 'tabs/data_collection_tab.dart';
import 'tabs/info_analysis_tab.dart';
import 'tabs/patient_management_tab.dart';
import 'tabs/post_event_tab.dart';
import 'tabs/home_page.dart';

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
  int _currentIndex = 0; // Ensure the default index is 0, which is the HomePage

  final List<Widget> _tabs = [
    const HomePage(),
    const DataCollectionTab(),
    const InfoAnalysisTab(),
    const PatientManagementTab(),
    const PostEventTab(),
  ];

  final List<String> _tabTitles = [
    'Home', // Missing comma between 'Home' and 'Data Collection'
    'Data Collection',
    'Information Analysis',
    'Patient Management',
    'Post-Event'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabTitles[_currentIndex]),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Navigation',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                setState(() {
                  _currentIndex = 0; // Ensure Home is selected
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: _tabs[_currentIndex], // Display the selected tab
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
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
