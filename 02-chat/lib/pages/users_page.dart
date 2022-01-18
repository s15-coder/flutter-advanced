import 'package:chat/models/user.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);
  static const routeName = "UsersPage";

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final connected = true;
  RefreshController _refreshController = RefreshController();
  var users = [
    User(
      online: true,
      name: "Sergio",
      email: "Serestebanoo@gmail.com",
      uuid: "1",
    ),
    User(
      online: false,
      name: "Juan",
      email: "juan@gmail.com",
      uuid: "2",
    ),
    User(
      online: true,
      name: "Ramiro",
      email: "ramiro@gmail.com",
      uuid: "3",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Sergio",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 5),
              padding: EdgeInsets.all(1),
              child: Icon(connected ? Icons.check : Icons.offline_bolt),
              decoration: BoxDecoration(
                color: connected ? Colors.green : Colors.red,
                shape: BoxShape.circle,
              ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          header: const WaterDropHeader(
            waterDropColor: Colors.blue,
            complete: Icon(
              Icons.check,
              color: Colors.green,
            ),
          ),
          child: _ListUsers(users: users),
          onRefresh: _loadUsers,
        ));
  }

  void _loadUsers() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}

class _ListUsers extends StatelessWidget {
  const _ListUsers({Key? key, required this.users}) : super(key: key);
  final List<User> users;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) => _UserTile(user: users[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: users.length);
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(
          user.name.substring(0, 2).toUpperCase(),
        ),
      ),
      trailing: Container(
        height: 6,
        width: 6,
        decoration: BoxDecoration(
            color: user.online ? Colors.green : Colors.red,
            shape: BoxShape.circle),
      ),
    );
  }
}
