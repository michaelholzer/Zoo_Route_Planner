import 'package:flutter/material.dart';
import 'package:zoo_route_planner/route_logic.dart';
import 'package:zoo_route_planner/route_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(animalList: [], start: 0),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.animalList, required this.start});

  final List<bool> animalList;
  final int start;

  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() => _MyHomePageState(animalList: animalList, start: start);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({required this.animalList, required this.start});

  List<bool> animalList;
  int start;

  List<bool> animalSelected = [false, false, false, false, false, false, false, false, false];
  List selectedAnimals = [];

  final DijkstrasAlgorithm algorithm = DijkstrasAlgorithm();

  @override
  void initState() {
    super.initState();
    /// Set local animalSelected to the passed animal list when applicable
    if (animalList.isNotEmpty) {
      animalSelected.clear();
      animalSelected.addAll(animalList);

      /// Add animals as selected that are selected
      for (int i = 0; i < animalSelected.length; i++) {
        if (animalSelected[i]) selectedAnimals.add(algorithm.getName(i));
      }
      selectedAnimals.sort();
    }
  }

  void _moveToRoute () {
    setState((){});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RouteMap(animalList: animalSelected, start: start)),
    );
  }

  /// Update local selectedAnimals and animalSelected
  /// Update associated algorithm List
  void _changeAnimalState (int index) {
    setState((){
      animalSelected[index] = !animalSelected[index];
      if (animalSelected[index]) {
        selectedAnimals.add(algorithm.getName(index));
        algorithm.setState(index, true);
        selectedAnimals.sort();
      } else {
        selectedAnimals.remove(algorithm.getName(index));
        algorithm.setState(index, false);
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
              dividerHeight: 3,
              dividerColor: Colors.lightGreen,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              tabs: [
                Tab(
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 30,),
                  ),
                ),
                Tab(
                  child: Text(
                    'Selected',
                    style: TextStyle(fontSize: 30,),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              /// "Add" Tab
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
                          minVerticalPadding: 2,
                          dense: true,
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
                              algorithm.getName(index),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            )
                          )
                        );
                      },
                      childCount: algorithm.getAmount(),
                    ),
                  ),
                ],
              ),
              /// "Selected" Tab
              CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ListTile(
                          minVerticalPadding: 5,
                          dense: true,
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
