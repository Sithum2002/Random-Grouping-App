import 'dart:math';

import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<String> userList = [];
  final TextEditingController _userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User List',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: () {
                _showAddUserDialog();
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${index + 1}. ${userList[index]}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createRandomGroups();
        },
        child: const Icon(Icons.group),
      ),
    );
  }

  void _showAddUserDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add User'),
          content: TextField(
            controller: _userNameController,
            decoration: const InputDecoration(labelText: 'Enter User Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addUser();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addUser() {
    String userName = _userNameController.text.trim();
    if (userName.isNotEmpty && !userList.contains(userName)) {
      setState(() {
        userList.add(userName);
      });
      _userNameController.clear();
      Navigator.pop(context);
    } else {
      // Display error message for duplicate names
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Try to add a new user. Duplicate names are not allowed.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _showGroupsDialog(List<List<String>> groups) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('User Groups'),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < groups.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Group ${i + 1}',
                        style:
                            const TextStyle(fontFamily: 'MyFont', fontSize: 30),
                      ),
                      for (int j = 0; j < groups[i].length; j++)
                        ListTile(
                          title: Text(groups[i][j]),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _createRandomGroups() {
    if (userList.length < 9) {
      _showPopupMessage("Need minimum 9 members to generate groups");
      return;
    }

    List<String> shuffledList = List.from(userList);

    shuffledList.shuffle();

    int numberOfGroups = (shuffledList.length / 5).floor();

    int remainder = shuffledList.length % 5;

    List<List<String>> groups = [];
    for (int i = 0; i < numberOfGroups; i++) {
      int startIndex = i * 5;
      int endIndex = (i + 1) * 5;
      List<String> group = shuffledList.sublist(startIndex, endIndex);
      groups.add(group);
    }

    if (remainder == 4) {
      List<String> newGroup = shuffledList.sublist(shuffledList.length - 4);
      groups.add(newGroup);
    } else if (remainder == 3) {
      if (numberOfGroups >= 3) {
        for (int i = 0; i < 3; i++) {
          int randomGroupIndex = Random().nextInt(numberOfGroups);
          groups[randomGroupIndex].add(shuffledList.removeLast());
        }
      } else if (numberOfGroups == 2) {
        groups[0].add(shuffledList.removeLast());
        groups[1].add(shuffledList.removeLast());
        groups[1].add(shuffledList.removeLast());
      }
    } else if (remainder == 2) {
      if (numberOfGroups >= 2) {
        for (int i = 0; i < 2; i++) {
          int randomGroupIndex = Random().nextInt(numberOfGroups);
          groups[randomGroupIndex].add(shuffledList.removeLast());
        }
      } else if (numberOfGroups == 1) {
        groups[0].add(shuffledList.removeLast());
        groups[0].add(shuffledList.removeLast());
      }
    } else if (remainder == 1) {
      for (int i = 0; i < 1; i++) {
        int randomGroupIndex = Random().nextInt(numberOfGroups);
        groups[randomGroupIndex].add(shuffledList.removeLast());
      }
    }

    setState(() {
      _showGroupsDialog(groups);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GroupsDisplayWidget(groups: groups),
        ),
      );
    });
  }

  void _showPopupMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class GroupsDisplayWidget extends StatelessWidget {
  final List<List<String>> groups;

  const GroupsDisplayWidget({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups Display',
            style: TextStyle(fontFamily: 'MyFont', fontSize: 35),
            textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                'Group ${index + 1}',
                style: const TextStyle(fontFamily: 'MyFont', fontSize: 30),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: groups[index]
                    .map((member) => Text(
                          member,
                          style: const TextStyle(fontSize: 25),
                        ))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
