import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Function(int)? onTabChange;

  const HomePage({super.key, this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.orange.shade200,
                Colors.orange.shade800,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Icon or Logo Placeholder
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.document_scanner_outlined,
                      size: 80,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Welcome Text
                Text(
                  'Emergency Documentation App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black45,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Subtitle
                Text(
                  'Your Lifeline in Critical Moments',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 40),
                // Start Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Info Analysis tab
                    if (onTabChange != null) {
                      onTabChange!(2); // Index 2 is Info Analysis tab
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.orange.shade800,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
