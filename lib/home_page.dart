import 'package:flutter/material.dart';
import 'user_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Grouping-X',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'MyFont',
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 8, 45, 75),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/group.png',
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserListPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(30.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.0),
              ),
            ),
            child: const Text(
              'Add to List',
              style: TextStyle(fontSize: 30, fontFamily: 'MyFont'),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              'About Us',
              style: TextStyle(fontSize: 24, fontFamily: 'MyFont'),
            ),
          ),
        ],
      ),
    );
  }
}
