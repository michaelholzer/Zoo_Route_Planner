import 'package:flutter/material.dart';
import 'package:zoo_route_planner/location_changer.dart';
import 'package:zoo_route_planner/main.dart';
import 'package:zoo_route_planner/route_logic.dart';
import 'package:zoo_route_planner/route_text.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RouteMap extends StatefulWidget {
  const RouteMap({super.key, required this.animalList, required this.start});

  final List<bool> animalList;
  final int start;

  @override
  // ignore: no_logic_in_create_state
  State<RouteMap> createState() => _RouteMapState(animalList: animalList, start: start);
}

class _RouteMapState extends State<RouteMap> {
  _RouteMapState({required this.animalList, required this.start});

  List<bool> animalList = [];
  int start;

  final DijkstrasAlgorithm algorithm = DijkstrasAlgorithm();

  void _moveToPlan () {
    setState((){});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(animalList: animalList, start: start)),
    );
  }

  void _moveToText () {
    setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RouteText(animalList: animalList, start: start)),
    );
  }

  void _moveToLocation () {
    setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationChange(from: 'Map', animalList: animalList, start: start)),
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
                      width: 2,
                      color: Colors.grey,
                    ),
                  ),
                  onPressed: _moveToLocation,
                  child: Text(
                    'Current Location:\n${algorithm.getName(start)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 2,
                      color: Colors.grey,
                    ),
                  ),
                  onPressed: _moveToText,
                  child: const Text(
                    'View Text Directions',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 75,
              child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text('This is the map, it\'s the map it\'s the map', style: Theme.of(context).textTheme.headlineSmall,)
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
