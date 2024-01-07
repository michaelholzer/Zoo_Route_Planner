import 'package:flutter/material.dart';
import 'package:zoo_route_planner/routeMain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Animal Addition'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _moveToRoute () {
    setState((){});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RouteMain(title: 'routeMain')),
    );
  }

  void _test () {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Animals'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Add',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Tab(
                  child: Text(
                    'Selected',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    title: Text('(Future) Search'),
                    backgroundColor: Colors.red,
                    expandedHeight: 50,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ListTile(title: OutlinedButton(onPressed: _test, child:Text('Add #$index'))),
                      childCount: 20,
                    ),
                  ),
                ],
              ),
              CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ListTile(title: Text('Selected #$index')),
                      childCount: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 65,
              child: Container (
                alignment: Alignment.center,
                child: Text(
                  'Plan',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),
            Expanded(
              flex: 35,
              child: ElevatedButton(
                onPressed: _moveToRoute,
                child: Text(
                  'Route',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
