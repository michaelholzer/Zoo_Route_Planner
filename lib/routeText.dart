import 'package:flutter/material.dart';
import 'package:zoo_route_planner/main.dart';
import 'package:zoo_route_planner/routeMain.dart';
import 'locationChanger.dart';

class RouteText extends StatefulWidget {
  const RouteText({super.key, required this.title});

  final String title;

  @override
  State<RouteText> createState() => _RouteTextState();
}

class _RouteTextState extends State<RouteText> {

  void _moveToPlan () {
    setState((){});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage(title: 'MyHomepage')),
    );
  }

  void _moveToMap () {
    setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RouteMain(title: 'routeMain')),
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
                onPressed: _moveToMap,
                child: Text('Map View', style: Theme.of(context).textTheme.headlineSmall,),
              ),
            ),
            Expanded(
              flex: 72,
              child: Container(
                width: 350,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Text('TEXT list of directions', style: Theme.of(context).textTheme.headlineSmall,)
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
