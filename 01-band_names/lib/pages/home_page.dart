import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: "1", name: "DP", votes: 5),
    Band(id: "2", name: "Maroon 5", votes: 9),
    Band(id: "3", name: "Metalica", votes: 7),
    Band(id: "4", name: "Post Malo  ne", votes: 13),
    Band(id: "5", name: "The weeknd", votes: 3),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Band Names",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [],
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (_, i) {
            return BandItem(band: bands[i]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();
    if (!Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text("Add new band:"),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  child: const Text("Add"),
                  onPressed: () => validateNewBand(textController.text),
                )
              ],
            );
          });
    }
    if (!Platform.isIOS) {
      return showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: const Text("Add new band:"),
              content: CupertinoTextField(
                controller: textController,
              ),
              actions: [
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text("Dissmis"),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text("Add"),
                  onPressed: () => validateNewBand(textController.text),
                ),
              ],
            );
          });
    }
  }

  void validateNewBand(String name) {
    if (name.length > 1) {
      bands.add(Band(
        id: DateTime.now().microsecond.toString(),
        name: name,
        votes: 0,
      ));
      setState(() {});
    }
    Navigator.pop(context);
  }
}

class BandItem extends StatelessWidget {
  const BandItem({
    Key? key,
    required this.band,
  }) : super(key: key);

  final Band band;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {},
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.only(left: 10),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Delete Band",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text(
          band.votes.toString(),
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
