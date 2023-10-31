// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:english_words/english_words.dart';
import 'pages/splash_page.dart';
import 'pages/one_step_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final myAppStateProvider = ChangeNotifierProvider((ref) => MyAppState());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromRGBO(0, 255, 42, 1),
            brightness: Brightness.dark),
      ),
      home: SplashPage(),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
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

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedIndex = ref.watch(selectedIndexProvider);

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = OneStepPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // WORKING
    return Scaffold(
      body: Row(
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
                  icon: Icon(Icons.sports_martial_arts),
                  label: Text('One Steps'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                ref
                    .read(selectedIndexProvider.notifier)
                    .setSelectedIndex(value);
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: DecoratedBox(
                  child: page,
                  decoration: BoxDecoration(
                      border: Border(
                          left:
                              BorderSide(color: Color(0xFF00305c), width: 2)))),
            ),
          )
        ],
      ),
    );
  }
}

final selectedIndexProvider =
    StateNotifierProvider<SelectedIndexNotifier, int>((ref) {
  return SelectedIndexNotifier();
});

class SelectedIndexNotifier extends StateNotifier<int> {
  SelectedIndexNotifier() : super(0);

  void setSelectedIndex(int index) {
    state = index;
  }
}

class GeneratorPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var appState = ref.watch(myAppStateProvider);
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
                  // ref.read(calloutStateProvider.notifier).add('banana');
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  ref.read(myAppStateProvider.notifier).getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class OneStepPage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var calloutState = ref.watch(calloutStateProvider);
//     List<Widget> widgets = [];
//     List enabled = calloutState.where((callout) => callout.enabled).toList();

//     for (var pair in calloutState) {
//       widgets.add(CheckboxListTile(
//           title: Text(pair.title),
//           value: pair.enabled,
//           onChanged: (value) {
//             ref.read(calloutStateProvider.notifier).toggle(pair.id);
//             return;
//           }));
//     }

//     return Column(
//       children: [
//         Row(
//           children: [
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'One Steps',
//                   textAlign: TextAlign.center,
//                   // overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 40),
//                 ),
//                 Text(
//                   'Enabled ${enabled.length}',
//                   textAlign: TextAlign.center,
//                   // overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(fontSize: 14),
//                 )
//               ],
//             )
//           ],
//         ),
//         Expanded(
//             child: Row(
//           children: [
//             Flexible(
//                 child: Scrollbar(
//                     thumbVisibility: true,
//                     controller: _firstController,
//                     child: ListView.builder(
//                         controller: _firstController,
//                         itemCount: widgets.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return widgets[index];
//                         })))
//           ],
//         ))
//       ],
//     );
//   }
// }

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.headline6!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}
