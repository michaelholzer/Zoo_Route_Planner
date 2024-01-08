import 'package:flutter/material.dart';
import 'package:zoo_route_planner/locationChanger.dart';
import 'package:zoo_route_planner/main.dart';
import 'package:zoo_route_planner/routeText.dart';

class RouteMain extends StatefulWidget {
  const RouteMain({super.key, required this.title});

  final String title;

  @override
  State<RouteMain> createState() => _RouteMainState();
}

class _RouteMainState extends State<RouteMain> {

  void _moveToPlan () {
    setState((){});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage(title: 'MyHomepage')),
    );
  }

  void _moveToText () {
    setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RouteText(title: 'routeText')),
    );
  }

  void _moveToLocation () {
    setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationChange(title: 'locationChange')),
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
                flex: 3,
                child: Container(

                )
            ),
            Expanded(
              flex: 15,
              child: ElevatedButton(
                onPressed: _moveToLocation,
                child: Text('Current Location: Location', style: Theme.of(context).textTheme.headlineSmall,),
              ),
            ),
            Expanded(
              flex: 10,
              child: ElevatedButton(
                onPressed: _moveToText,
                child: Text('Text View', style: Theme.of(context).textTheme.headlineSmall,),
              ),
            ),
            Expanded(
              flex: 72,
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
