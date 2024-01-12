// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zoo_route_planner/routeLogic.dart';
import 'package:zoo_route_planner/routeMap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Animal Addition', animalList: [],),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, required this.animalList});

  final String title;
  final List animalList;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final DijkstrasAlgorithm algorithm = DijkstrasAlgorithm();

  // this could eventually become a map depending on what functionality is needed
  List animalNames = ['A zero', 'B one', 'C two', 'D three', 'E four', 'F five', 'G six', 'H seven', 'I eight'];
  List<bool> animalSelected = [false, false, false, false, false, false, false, false, false];
  List selectedAnimals = [];

  void _moveToRoute () {
    setState((){});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RouteMap(title: 'routeMain', animalList: animalSelected,)),
    );
    // algorithm.RunAlgorithm();
  }

  void _changeAnimalState (int index) {
    setState((){
      animalSelected[index] = !animalSelected[index];
      if (animalSelected[index]) {
        selectedAnimals.add(animalNames[index]);
        // algorithm.setState(index, true);
        selectedAnimals.sort();
      } else {
        selectedAnimals.remove(animalNames[index]);
        // algorithm.setState(index, false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Container(
              alignment: Alignment.center,
              child:const Text(
                'What animals would\nyou like to see?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Selected',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // "Add" Tab
              CustomScrollView(
                slivers: [
                  const SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    title: Text('(Future) Search'),
                    backgroundColor: Colors.red,
                    expandedHeight: 50,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ListTile(
                          minVerticalPadding: 0,
                          contentPadding: const EdgeInsets.all(10),
                          title: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              backgroundColor: animalSelected[index] ? Colors.blue : Colors.grey,
                              side: const BorderSide(width: 2, color: Colors.black,),
                            ),
                            onPressed: () { _changeAnimalState(index); },
                            child:Text(
                              animalNames[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            )
                          )
                        );
                      },
                      childCount: animalNames.length,
                    ),
                  ),
                ],
              ),
              // "Selected" Tab
              CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ListTile(
                          title: Text(
                            (selectedAnimals.isEmpty) ? "No Animals Selected" : selectedAnimals[index],
                            style: TextStyle(
                              fontSize: (selectedAnimals.isEmpty) ? 25 : 20,
                            ),
                          ),
                        );
                      },
                      childCount: (selectedAnimals.isEmpty) ? 1 : selectedAnimals.length,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 65,
              child: Container (
                alignment: Alignment.center,
                child: const Text(
                  'Plan',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                onPressed: _moveToRoute,
                child: const Text(
                  'Route',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
