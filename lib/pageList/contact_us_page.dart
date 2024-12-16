import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Get in Touch',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'We would love to hear from you! Please feel free to reach out to us using the following contact details or by filling out the feedback form below.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              const Text(
                'Contact Information:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.email, color: Colors.deepOrange),
                  SizedBox(width: 8),
                  Text('yossi.heifetz06@gmail.com',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.phone, color: Colors.deepOrange),
                  SizedBox(width: 8),
                  Text('0533832023', style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Feedback Form:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Your Message',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  onPressed: () {
                    // Implement form submission logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Message sent!')),
                    );
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
