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
    // for debug purposes
    print(animalList);
    print(order);
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 15,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  onPressed: _moveToLocation,
                  child: const Text(
                    'Current Location:\nLocation',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      onPressed: _moveToMap,
                      child: const Text(
                        'View Map Directions',
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
            Expanded(
              flex: 75,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.green),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ListTile(
                            textColor: Colors.black,
                            minVerticalPadding: 0,
                            contentPadding: const EdgeInsets.all(5),
                            title: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.grey),
                                borderRadius: const BorderRadius.all(Radius.circular(2)),
                              ),
                              child: Text(
                                order[index].toString(),
                                style: const TextStyle(fontSize: 20,),
                              )
                            ),
                          );
                        },
                        childCount: order.length,
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
