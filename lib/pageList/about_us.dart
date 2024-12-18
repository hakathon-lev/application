import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade100, Colors.orange.shade300],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                      'assets/images/image.png'), // Replace with your image path
                ),
                const SizedBox(height: 20),
                const Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome to the Emergency Documentation App. Our mission is to provide smart and precise documentation tools for medical events, ensuring efficient data collection, case analysis, and file management for better outcomes.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.black54),
                const SizedBox(height: 20),
                const Text(
                  'Our Vision',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'We envision a world where medical professionals can focus on saving lives, while technology takes care of documentation seamlessly and efficiently.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.black54),
                const SizedBox(height: 20),
                const Text(
                  'Our Values',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.orange),
                      title: Text(
                          'Innovation: Constantly improving through advanced technology.'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.orange),
                      title: Text(
                          'Efficiency: Streamlining processes to save time and effort.'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.orange),
                      title: Text(
                          'Accuracy: Ensuring data reliability for critical decisions.'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.orange),
                      title: Text(
                          'Empathy: Supporting healthcare professionals in high-pressure situations.'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.black54),
                const SizedBox(height: 20),
                const Text(
                  'Meet Our Team',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Our team consists of passionate developers, designers, and healthcare experts dedicated to creating solutions for the medical field.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                          'assets/images/team_member4.png'), // Replace with team member images
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                          'assets/images/team_member5.png'), // Replace with team member images
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                          'assets/images/team_member1.jpg'), // Replace with team member images
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                          'assets/images/team_member2.png'), // Replace with team member images
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                          'assets/images/team_member3.jpg'), // Replace with team member images
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality here (e.g., navigate to another page)
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    backgroundColor: Colors.orange.shade300,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Learn More',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
