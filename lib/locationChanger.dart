import 'package:flutter/material.dart';
import 'package:zoo_route_planner/routeLogic.dart';
import 'package:zoo_route_planner/routeMap.dart';
import 'package:zoo_route_planner/routeText.dart';

class LocationChange extends StatefulWidget {
  const LocationChange({super.key, required this.from, required this.animalList, required this.start});

  final String from;
  final List<bool> animalList;
  final int start;

  @override
  State<LocationChange> createState() => _LocationChangeState(from: from, animalList: animalList, start: start);
}

class _LocationChangeState extends State<LocationChange> {
  _LocationChangeState({required this.from, required this.animalList, required this.start});

  String from;
  List<bool> animalList;
  int start;

  final DijkstrasAlgorithm algorithm = DijkstrasAlgorithm();

  List<bool> _selectedLocation = [];

  @override
  void initState() {
    super.initState();

    _selectedLocation = List.filled(algorithm.getAmount(), false);
    _setLocation(start);
  }

  void _setLocation(int index) {
    setState((){});
    // set index true and set all others false
    for (int i = 0; i < _selectedLocation.length; i++) {
      _selectedLocation[i] = false;
    }
    _selectedLocation[index] = true;
    start = index;
  }

  void _confirmLocation() {
    setState((){});
    // navigate back to text or map, wherever user came from
    if (from == 'Map') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RouteMap(animalList: animalList, start: start)),
      );
    } else if (from == 'Text') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RouteText(animalList: animalList, start: start)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Location: Current Location'),
        automaticallyImplyLeading: false,
      ),
      body: CustomScrollView(
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
              // (context, index) => ListTile(title: Text('Location #$index')),
              (context, index) {
                return ListTile(
                  title: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: _selectedLocation[index] ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () { _setLocation(index); },
                    child: Text(
                      'Location #$index',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  )
                );
              },
              childCount: algorithm.getAmount(), // this call may change
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            side: const BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
          onPressed: _confirmLocation,
          child: Text(
            style: Theme.of(context).textTheme.headlineSmall,
            'Set Current Location'
          ),
        ),
      ),
    );
  }
}
