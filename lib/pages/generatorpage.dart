import 'package:flutter/material.dart';
import 'package:namer_app/pages/appstate.dart';
import 'package:namer_app/pages/bigcarg.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.previuos();
                },
                icon: Icon(Icons.arrow_back),
                label: Text('Previous'),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  appState.getNext();
                },
                label: Text('Next'),
                icon: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}