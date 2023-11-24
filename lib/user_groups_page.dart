import 'package:flutter/material.dart';

class UserGroupsPage extends StatelessWidget {
  final List<List<String>> groups;
  const UserGroupsPage({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Groups',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Group ${index + 1}'),
            subtitle: Text(groups[index].join(', ')),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

