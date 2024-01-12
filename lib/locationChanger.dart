import 'package:flutter/material.dart';
import 'package:zoo_route_planner/routeLogic.dart';

class LocationChange extends StatefulWidget {
  const LocationChange({super.key, required this.animalList});

  final List animalList;

  @override
  State<LocationChange> createState() => _LocationChangeState();
}

class _LocationChangeState extends State<LocationChange> {

  final DijkstrasAlgorithm algorithm = DijkstrasAlgorithm();

  void _setLocation() {
    // algorithm.RunAlgorithm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Location: Current Location'),
        // add following in exchange for using button on bottom
        // automaticallyImplyLeading: false,
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
              (context, index) => ListTile(title: OutlinedButton(onPressed: _setLocation,child:Text('Location #$index'),)),
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
          onPressed: _setLocation,
          child: Text(
            style: Theme.of(context).textTheme.headlineSmall,
            'Set Current Location'
          ),
        ),
      ),
    );
  }
}
