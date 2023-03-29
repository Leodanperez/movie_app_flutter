import 'package:flutter/material.dart';
import 'package:movie_app/constants/style.dart';
import 'package:movie_app/screens/movie_screen.dart';
import 'package:movie_app/screens/tv_screen.dart';
import 'package:movie_app/screens/watch_lists_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    void onTapIcon(int index) {
      controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }

    return Scaffold(
      appBar: _currentIndex != 2 ? AppBar(
        centerTitle: true,
        title: _buildTitle(_currentIndex),
      ) : null,
      body: PageView(
        controller: controller,
        children: const <Widget>[
          MovieScreen(),
          TVsScreen(),
          WatchLists()
          //Center(child: Text('Watch List', style: TextStyle(color: Style.textColor)),),
        ],
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Style.primaryColor,
        selectedItemColor: Style.secondColor,
        unselectedItemColor: Style.textColor,
        onTap: onTapIcon,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'TVs'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Watch List'),
        ],
      ),
    );
  }

  _buildTitle(int index) {
    switch(index) {
      case 0:
        return const Text('Movie Shows');
      case 1:
        return const Text('TV Shows');
      /*case 2:
        return null; //return null if navigate to watch list*/
      default:
        return null;
    }
  }
}
