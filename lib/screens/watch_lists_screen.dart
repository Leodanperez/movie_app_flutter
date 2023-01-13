import 'package:flutter/material.dart';

class WatchLists extends StatefulWidget {
  const WatchLists({Key? key}) : super(key: key);

  @override
  State<WatchLists> createState() => _WatchListsState();
}

class _WatchListsState extends State<WatchLists> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watch List'),
          bottom: const TabBar(
            tabs: [
              Text(
                'Movies',
                style: TextStyle(fontSize: 28),
              ),
              Text(
                'TVs',
                style: TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
