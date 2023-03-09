import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  //each flutter project has a widget method which tells what the widget contains
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          // colorScheme:
          //     ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 146, 79, 3)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var words = <WordPair>[];
  void getNext() {
    words.insert(0, current);
    current = WordPair.random();
    notifyListeners();
  }

  int index = 0;
  void previuos() {
    current = words[index];
    if (index < words.length - 1) {
      index++;
    } else {
      index = words.length - 1;
    }
    if (index >= words.length - 1) {
      index = words.length - 1;
    }
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

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

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Text(
          pair.asPascalCase,
          style: style,
          semanticsLabel: pair.asCamelCase,
        ),
      ),
    );
  }
}

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
