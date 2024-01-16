import 'package:flutter/material.dart';
import 'package:zoo_route_planner/main.dart';
import 'package:zoo_route_planner/route_logic.dart';
import 'package:zoo_route_planner/route_map.dart';
import 'package:zoo_route_planner/location_changer.dart';

class RouteText extends StatefulWidget {
  const RouteText({super.key, required this.animalList, required this.start});

  final List<bool> animalList;
  final int start;

  @override
  // ignore: no_logic_in_create_state
  State<RouteText> createState() => _RouteTextState(animalList: animalList, start: start);
}

class _RouteTextState extends State<RouteText> {
  _RouteTextState({required this.animalList, required this.start});

  List<bool> animalList;
  int start;

  List order = [];

  final DijkstrasAlgorithm algorithm = DijkstrasAlgorithm();

  @override
  void initState() {
    super.initState();
    algorithm.assignData();

    /// Save information from animalList
    List<bool> tempList = [];
    tempList.addAll(animalList);
    /// Set algorithm values to  user inputted values
    algorithm.setVisitState(animalList);
    algorithm.setStart(start);
    /// This next line sets animalList to false (for some reason)
    algorithm.runAlgorithm();
    order = algorithm.getFullOrder();
    /// Repair list so animalList isn't false for all values
    animalList.clear();
    animalList.addAll(tempList);

    List<int> trueOrder = [];
    /// Add lines for route and add details to order
    for (int i = 0; i < order.length - 2; i++) {
      if (!algorithm.pointsConnect(order[i], order[i+1])) {
        List<int> tree = algorithm.getTree(order[i], order[i+1]);
        /// Tree is in reversed order, so a reversed order for statement fetches the correct order
        for (int j = tree.length - 1; j >= 0; j--) {
          if (j != 0) trueOrder.add(tree[j]);
        }
      } else {
        trueOrder.add(order[i]);
      }
    }
    trueOrder.add(order[order.length - 2]);
    order.clear();
    order.addAll(trueOrder);
    order.add(-1); /// -1 signifies end of route
  }

  void _moveToPlan () {
    setState((){});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(animalList: animalList, start: start)),
    );
  }

  void _moveToMap () {
    setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RouteMap(animalList: animalList, start: start)),
    );
  }

  void _moveToLocation () {
    setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationChange(from: 'Text', animalList: animalList, start: start)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          'Directions of your Route',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 13,
              child: Row(
                children: [
                  Expanded(
                    flex: 66,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      color: Colors.lightGreen,
                      height: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          side: const BorderSide(
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: _moveToLocation,
                        child: Text(
                          'Starting Location:\n${algorithm.getName(start)}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 34,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      color: Colors.lightGreen,
                      height: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25))
                          ),
                          side: const BorderSide(
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: _moveToMap,
                        child: const Text(
                          'View as\nMap',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 87,
              child: Container(
                color: Colors.grey,
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ListTile(
                            textColor: Colors.black,
                            minVerticalPadding: 2,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            dense: true,
                            title: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.blueGrey),
                                borderRadius: const BorderRadius.all(Radius.circular(2)),
                              ),
                              child: Text(
                                '${algorithm.getName(order[index])}:\n'
                                  '${(order[index+1] == -1) ? algorithm.getDirection(-2, -2) : algorithm.getDirection(order[index], order[index + 1])}',
                                style: const TextStyle(fontSize: 20,),
                              )
                            ),
                          );
                        },
                        childCount: order.length - 1,
                      )
                    )
                  ],
                )
              )
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                onPressed: _moveToPlan,
                child: const Text(
                  'Plan',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 65,
              child: Container (
                alignment: Alignment.center,
                child: const Text(
                  'Route',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
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
