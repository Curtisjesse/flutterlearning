import 'package:flutter/material.dart';
import 'package:namer_app/pages/appstate.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'You have '
            '${appState.favorites.length} favorites:',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
              fontSize: 28,
            ),
          ),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 27,
            ),
            title: Text(
              pair.asString[0].toUpperCase() + pair.asString.substring(1),
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
      ],
    );
  }
}
