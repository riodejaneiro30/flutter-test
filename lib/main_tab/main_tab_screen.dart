import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/favorite/favorite_screen.dart';
import 'package:moviedb/main_tab/main_tab_view_model.dart';
import 'package:moviedb/movie/movie_screen.dart';
import 'package:moviedb/people/people_screen.dart';

class MainTabScreen extends ConsumerWidget {
  Widget getScreen(int index) {
    switch (index) {
      case 0:
        return MovieScreen();
      case 1:
        return FavoriteScreen();
      case 2:
        return PeopleScreen();
      default:
        return MovieScreen();
    }
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _index = watch(mainTabViewModelProvider);

    return Scaffold(
      body: getScreen(_index),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(25, 25, 38, 100),
          items: [
            BottomNavigationBarItem(
                icon: Container(
                    height: 30,
                    margin: EdgeInsets.only(bottom: 5),
                    child: _index == 0
                        ? Image.asset("assets/images/movies_active.png")
                        : Image.asset("assets/images/movies_inactive.png")),
                label: 'Movies'),
            BottomNavigationBarItem(
                icon: Container(
                    height: 30,
                    margin: EdgeInsets.only(bottom: 5),
                    child: _index == 1
                        ? Image.asset("assets/images/favorite_active.png")
                        : Image.asset("assets/images/favorite_inactive.png")),
                label: 'Favorites'),
            BottomNavigationBarItem(
                icon: Container(
                    height: 30,
                    margin: EdgeInsets.only(bottom: 5),
                    child: _index == 2
                        ? Image.asset("assets/images/people_active.png")
                        : Image.asset("assets/images/people_inactive.png")),
                label: 'People')
          ],
          selectedLabelStyle: TextStyle(fontSize: 14),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          currentIndex: _index,
          selectedItemColor: Color.fromRGBO(255, 51, 101, 100),
          unselectedItemColor: Color.fromRGBO(109, 109, 128, 100),
          onTap: (int index) =>
              context.read(mainTabViewModelProvider.notifier).setTab(index)),
    );
  }
}
