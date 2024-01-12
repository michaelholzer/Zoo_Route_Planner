import 'package:flutter/material.dart';
import 'package:zoo_route_planner/main.dart';
import 'package:zoo_route_planner/routeLogic.dart';
import 'package:zoo_route_planner/routeMap.dart';
import 'package:zoo_route_planner/locationChanger.dart';

class RouteText extends StatefulWidget {
  const RouteText({super.key, required this.animalList});

  final List<bool> animalList;

  @override
  State<RouteText> createState() => _RouteTextState(animalList: animalList);
}

class _RouteTextState extends State<RouteText> {
  List<bool> animalList;
  List order = [];
  _RouteTextState({required this.animalList});
  // List<bool> visitList = animalList;

  final DijkstrasAlgorithm algorithm = DijkstrasAlgorithm();

  @override
  void initState() {
    super.initState();
    // save information from animalList
    List<bool> tempList = [];
    tempList.addAll(animalList);
    algorithm.setVisitState(animalList);
    // this next line sets animalList to false (for some reason)
    algorithm.runAlgorithm();
    order = algorithm.getFullOrder();
    // repair lists
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
      MaterialPageRoute(builder: (context) => MyHomePage(animalList: animalList)),
    );
  }

  void _moveToMap () {
    setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RouteMap(animalList: animalList)),
    );
  }

  void _moveToLocation () {
    setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationChange(animalList: animalList)),
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
                        'Map View',
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
