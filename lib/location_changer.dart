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
  int newStart = -1;
  List<String> _allNames = [];
  List<String> _searchResults = [];

  @override
  void initState() {
    super.initState();
    algorithm.assignData();
    /// Update local selectedLocation based on current start location
    _selectedLocation = List.filled(algorithm.getAmount(), false);
    _setLocation(start);

    _allNames = algorithm.getAllNames();
    _searchResults.addAll(_allNames);
    newStart = start;
  }

  void _setLocation(int index) {
    setState((){});
    /// Set index true and set all others false
    for (int i = 0; i < _selectedLocation.length; i++) {
      _selectedLocation[i] = false;
    }
    _selectedLocation[index] = true;
    newStart = index;
  }

  void _confirmLocation() {
    setState((){});
    /// Navigate back to text or map, wherever user came from
    start = newStart;
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

  void _searchChanged(String search) {
    setState(() {});
    _searchResults = _allNames.where((element) => element.toLowerCase().contains(search.toLowerCase())).toList();
  }

  bool _trueSelected (int index) {
    return _selectedLocation[algorithm.returnIndex(_searchResults[index])];
  }

  int _trueIndex (int index) {
    return algorithm.returnIndex(_searchResults[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Starting Location: ${algorithm.getName(start)}'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          TextField(
            autofocus: false,
            onChanged: _searchChanged,
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(
                fontSize: 20,
              ),
              prefixIcon: Container(
                padding: const EdgeInsets.all(5),
                child: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ListTile(
                        minVerticalPadding: 2,
                        dense: true,
                        title: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: _trueSelected(index) ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () { _setLocation(_trueIndex(index)); },
                          child: Text(
                            _searchResults[index],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        )
                      );
                    },
                    childCount: _searchResults.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: (newStart == start) ? Colors.white : Colors.lightGreen,
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
