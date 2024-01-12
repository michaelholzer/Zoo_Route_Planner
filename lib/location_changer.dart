import 'package:flutter/material.dart';
import 'package:zoo_route_planner/route_logic.dart';
import 'package:zoo_route_planner/route_map.dart';
import 'package:zoo_route_planner/route_text.dart';

class LocationChange extends StatefulWidget {
  const LocationChange({super.key, required this.from, required this.animalList, required this.start});

  final String from;
  final List<bool> animalList;
  final int start;

  @override
  // ignore: no_logic_in_create_state
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
    /// Update local selectedLocation based on current start location
    _selectedLocation = List.filled(algorithm.getAmount(), false);
    _setLocation(start);
  }

  void _setLocation(int index) {
    setState((){});
    /// Set index true and set all others false
    for (int i = 0; i < _selectedLocation.length; i++) {
      _selectedLocation[i] = false;
    }
    _selectedLocation[index] = true;
    start = index;
  }

  void _confirmLocation() {
    setState((){});
    /// Navigate back to text or map, wherever user came from
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
        backgroundColor: Colors.green,
        title: Text('Current Location: ${algorithm.getName(start)}'),
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
              (context, index) {
                return ListTile(
                  minVerticalPadding: 2,
                  dense: true,
                  title: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: _selectedLocation[index] ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () { _setLocation(index); },
                    child: Text(
                      algorithm.getName(index),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  )
                );
              },
              childCount: algorithm.getAmount(),
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
            'Set as Current Location'
          ),
        ),
      ),
    );
  }
}
