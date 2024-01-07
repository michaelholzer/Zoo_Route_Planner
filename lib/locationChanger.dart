import 'package:flutter/material.dart';

class LocationChange extends StatefulWidget {
  const LocationChange({super.key, required this.title});

  final String title;

  @override
  State<LocationChange> createState() => _LocationChangeState();
}

class _LocationChangeState extends State<LocationChange> {

  void _test() {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Location: Current Location'),
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
              (context, index) => ListTile(title: OutlinedButton(onPressed: _test,child:Text('Location #$index'),)),
              childCount: 20,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: ElevatedButton(
          onPressed: _test,
          child: Text(
            style: Theme.of(context).textTheme.headlineSmall,
            'Set Current Location'
          ),
        ),
      ),
    );
  }
}
