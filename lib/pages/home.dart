import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/pages/favoritepage.dart';
import 'package:namer_app/pages/generatorpage.dart';



class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Press'),
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 1, 13, 114),
          fontSize: 35,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 9, 228, 118),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://cdn.apartmenttherapy.info/image/upload/v1556716350/stock/8ea241e96504a398f291a31939963e8ba948368c.jpg",
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black54,
          ),
          Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: false,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  //color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
