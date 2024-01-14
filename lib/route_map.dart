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

  List order = [];

  final DijkstrasAlgorithm algorithm = DijkstrasAlgorithm();

  List<Marker> allMarkers = [];
  List<Polyline> allLines = [];
  List<Polyline> routeLines = [];

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

    /// Set Markers for every location
    for (int i = 0; i < algorithm.getAmount(); i++) {
      Color markerColor = Colors.black;
      double heightWidth = 15;
      String boxNumber = '';
      if (i == start) {
        markerColor = Colors.blue;
        heightWidth = 30;
        boxNumber = '0';
      } else if (animalList[i]) {
        markerColor = Colors.green;
        heightWidth = 30;
        boxNumber = order.indexOf(i).toString();
      }

      allMarkers.add(
        Marker(
          height: heightWidth,
          width: heightWidth,
          point: LatLng(algorithm.getXCoordinate(i), algorithm.getYCoordinate(i)),
          child: ColoredBox(
            color: markerColor,
            child: Text(
              boxNumber,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      );
    }

    List<int> trueOrder = [];
    /// Add lines for route and add details to order
    for (int i = 0; i < order.length - 2; i++) {
      routeLines.add(
        Polyline(
          color: Colors.black, strokeWidth: 2,
          points: [
            LatLng(algorithm.getXCoordinate(order[i]), algorithm.getYCoordinate(order[i])),
            LatLng(algorithm.getXCoordinate(order[i+1]), algorithm.getYCoordinate(order[i+1]))
          ]
        )
      );
      if (!algorithm.pointsConnect(order[i], order[i+1])) {
        List<int> tree = algorithm.getTree(order[i], order[i+1]);
        routeLines[i].points.clear();
        /// Tree is in reversed order, so a reversed order for statement fetches the correct order
        for (int j = tree.length - 1; j >= 0; j--) {
          routeLines[i].points.add(LatLng(algorithm.getXCoordinate(tree[j]), algorithm.getYCoordinate(tree[j])));
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          'Map of your Route',
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
                        onPressed: _moveToText,
                        child: const Text(
                          'View as\nText',
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
              child: FlutterMap(
                mapController: MapController(

                ),
                options: MapOptions(
                  /// Center map on San Diego Zoo
                  initialCenter: const LatLng(32.736, -117.151),
                  initialZoom: 17,
                  minZoom: 16,
                  maxZoom: 20,
                  cameraConstraint: CameraConstraint.contain(
                      bounds: LatLngBounds(
                          const LatLng(32.7395, -117.1555),
                          const LatLng(32.7325, -117.148)
                      )
                  ),
                ),
                children: [
                  TileLayer(
                    /// url gives map itself
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'edu.cpp.radio',
                  ),
                  PolylineLayer(
                    // use for route directions
                    polylines: routeLines,
                  ),
                  MarkerLayer(
                    rotate: true,
                    // use for location markers
                    markers: allMarkers,
                  ),
                  const RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                      ),
                    ],
                  ),
                ],
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
