import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  Future<void> _sendEmail() async {
    const String userEmail = 'chafetzy@yatmal.co.il'; // Replace with your email
    const String password = '216175yh'; // Replace with your email password

    final smtpServer = gmail(userEmail, password);

    final message = Message()
      ..from = Address(userEmail, 'Your App Name')
      ..recipients
          .add('recipient_email@gamil.com') // Replace with recipient email
      ..subject = 'Contact Us Message from ${_nameController.text}'
      ..text = '''
Name: ${_nameController.text}
Email: ${_emailController.text}
Message: ${_messageController.text}
''';

    try {
      final sendReport = await send(message, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Message sent: ${sendReport.toString()}')),
      );
      print('Message sent: ${sendReport.toString()}');
    } on MailerException catch (e) {
      print('Message not sent. Error: ${e.toString()}');
      if (e.problems.isNotEmpty) {
        for (var problem in e.problems) {
          print('Error Code: ${problem.code}, Details: ${problem.msg}');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
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
                    backgroundImage: AssetImage('assets/images/image.png'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'We would love to hear from you! Please fill out the form below.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Your Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _messageController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Your Message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _sendEmail,
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
                      'Submit',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
