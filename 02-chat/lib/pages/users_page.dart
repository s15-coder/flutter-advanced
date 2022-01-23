import 'package:chat/models/user.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);
  static const routeName = "UsersPage";

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController = RefreshController();
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            authService.user == null ? "No-name" : authService.user!.name,
            style: const TextStyle(color: Colors.black),
          ),
          elevation: 1,
          leading: IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              socketService.disconnect();
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
              AuthService.deleteToken();
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 5),
              padding: EdgeInsets.all(3),
              child: Icon(
                socketService.serverStatus == ServerStatus.online
                    ? Icons.check
                    : Icons.offline_bolt,
              ),
              decoration: BoxDecoration(
                color: socketService.serverStatus == ServerStatus.online
                    ? Colors.green
                    : Colors.red,
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
    users = await UsersService().getUsers();
    setState(() {});
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
          height: 7.5,
          width: 7.5,
          decoration: BoxDecoration(
              color: user.online ? Colors.green : Colors.red,
              shape: BoxShape.circle),
        ),
        onTap: () {
          final chatService = Provider.of<ChatService>(context, listen: false);
          chatService.userTo = user;
          Navigator.pushNamed(context, ChatPage.routeName);
        });
  }
}
