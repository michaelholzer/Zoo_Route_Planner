class DijkstrasAlgorithm {

  /// List of names for all items
  List<String> names = ['A zero', 'B one', 'C two', 'D three', 'E four', 'F five', 'G six', 'H seven', 'I eight'];
  String getName (int index) {
    if (index == -1) {
      return "Destination Reached";
    } else {
      return names[index];
    }
  }
  List<String> getAllNames () => names;
  int returnIndex (String name) {
    return names.indexOf(name);
  }

  /// Coordinate List for all points
  List<List<double>> coordinates = [
    [32.736, -117.1516],
    [32.7363, -117.1513],
    [32.7363, -117.151],
    [32.7363, -117.1507],
    [32.736, -117.1504],
    [32.7357, -117.1507],
    [32.7357, -117.151],
    [32.7357, -117.1513],
    [32.736, -117.151]
  ];
  double getXCoordinate (int index) => coordinates[index][0];
  double getYCoordinate (int index) => coordinates[index][1];

  /// Matrix of distances between nodes for algorithm
  static List<List<int>> adjacencyMatrix = [
    [  0,  4,  0,  0,  0,  0,  0,  8,  0 ],
    [  4,  0,  8,  0,  0,  0,  0, 11,  0 ],
    [  0,  8,  0,  7,  0,  4,  0,  0,  2 ],
    [  0,  0,  7,  0,  9, 14,  0,  0,  0 ],
    [  0,  0,  0,  9,  0, 10,  0,  0,  0 ],
    [  0,  0,  4, 14, 10,  0,  2,  0,  0 ],
    [  0,  0,  0,  0,  0,  2,  0,  1,  6 ],
    [  8, 11,  0,  0,  0,  0,  1,  0,  7 ],
    [  0,  0,  2,  0,  0,  0,  6,  7,  0 ]
  ];

  /// Return true if there is a connection between two locations
  bool pointsConnect (int one, int two) => (adjacencyMatrix[one][two] > 0);

  /// Amount of locations in the matrix
  static int amount = adjacencyMatrix.length;
  int getAmount () => amount;

  /// Starting location
  int start = 0;
  void setStart (int value) => start = value;
  // int getStart () => start;

  /// True if user wants to visit the animal
  List<bool> toVisit = List.filled(amount, false);
  void setState (int index, bool state) => toVisit[index] = state;
  // bool getState (int index) => toVisit[index];
  void setVisitState(List<bool> visits) => toVisit = visits;

  /// The outputted list of animals in shortest order
  List locationOrder = [];
  void setLocationOrder(List<int> order) => locationOrder = order;
  // String getLocationOrder(int index) => locationOrder[index].toString();
  // int getOrderAmount() => locationOrder.length;
  List getFullOrder () => locationOrder;

  /// Holds parent vertex to create shortest path tree
  // List<int> _parents = [];
  // int getParent(int index) => _parents[index];
  List<int> getTree (int a, int b) {

    List<List<int>> result = _dijkstra(adjacencyMatrix, a);

    List<int> tree = _fullPath(b, result[1], a);

    return tree;
  }

  /// Gives step by step shortest path from one vertex to another
  List<int> _fullPath (int currentVertex, List<int> parents, int start) {
    List<int> list = [currentVertex];
    if (currentVertex == start) {
      return list;
    }
    list.addAll(_fullPath(parents[currentVertex], parents, start));
    return list;
  }

  /// Calls the recursive function to give desired output
  void runAlgorithm () {
    /// Starting location is always visited
    toVisit[start] = false;
    /// Add start location to beginning of returned list
    List<int> finalList = [start];
    /// Add the rest of the major steps
    finalList.addAll(_recursiveSearch(adjacencyMatrix, start, toVisit));
    setLocationOrder(finalList);
  }
  
  List<int> _recursiveSearch (List<List<int>> graph, int start, List<bool> checks) {
    List<int> path = [];
    
    List<List<int>> solutions = _dijkstra(graph, start);

    /// Current vertex no longer needed to be visited
    checks[start] = false;
    int nextVertex = _minDistance(solutions[0], checks);
    path.add(nextVertex);

    // path.addAll(_fullPath(nextVertex, solutions[1], start));
    // _parents = solutions[1];

    /// Once all vertices are visited, return result
    if (_allVisited(checks)) {
      return path;
    } else {
      path.addAll(_recursiveSearch(graph, nextVertex, checks));
    }
    /// Catch case that shouldn't get visited
    return path;
  }

  /// Logical check if all values are false
  bool _allVisited (List<bool> toSee) {
    for (int i = 0; i < toSee.length; i++) {
      /// If any need to be seen, return false
      if (toSee[i]) return false;
    }
    /// If all have been seen, return true
    return true;
  }

  /// minDistance returns the index of the closest vertex
  int _minDistance (List<int> distance, List<bool> toSee) {
    /// Initialize min value to largest value possible
    int min = 0x7FFFFFFFFFFFFFFF;
    /// Initialize minIndex to impossible value
    int minIndex = -1;

    /// Find the shortest distance and associated index
    for (int i = 0; i < distance.length; i++) {
      /// Check if distance is shorter and if the vertex needs to be visited
      if (toSee[i] == true && distance[i] <= min) {
        min = distance[i];
        minIndex = i;
      }
    }

    return minIndex;
  }

  /// Main logistical function that computes Dijkstra's Algorithm
  List<List<int>> _dijkstra (List<List<int>> graph, int start) {
    /// Output list with two rows and one column per location in adjacency matrix
    /// Row 0 holds shortest distance to each vertex from the source
    /// Row 1 holds shortest path tree
    List<List<int>> outputs = List<List>.generate(2, (i) => List<int>.generate(amount, (index) => 0x7FFFFFFFFFFFFFFF, growable: false), growable: false).cast<List<int>>();

    /// Added array checks if each vertex is included
    List<bool> added = List<bool>.generate(amount, (index) => false);

    /// Start vertex distance is 0 and has no parent (-1)
    outputs[0][start] = 0;
    outputs[1][start] = -1;

    /// Find shortest path for all vertices
    /// Same logic as minDistance function with additional assignments
    for (int i = 1; i < amount; i++) {
      /// Set nearestVertex and shortestDistance to impossible values
      int nearestVertex = -1;
      int shortestDistance = 0x7FFFFFFFFFFFFFFF;

      /// Find shorter distance and associated index
      for (int vIndex = 0; vIndex < amount; vIndex++) {
        if (!added[vIndex] && (outputs[0][vIndex] < shortestDistance)) {
          nearestVertex = vIndex;
          shortestDistance = outputs[0][vIndex];
        }
      }

      /// Nearest vertex marked is processed
      added[nearestVertex] = true;

      /// Update distance value of adjacent vertices
      for (int vIndex = 0; vIndex < amount; vIndex++) {
        int edgeDistance = graph[nearestVertex][vIndex];

        // issue inside this function
        /// Update path tree when necessary
        if ((edgeDistance > 0) && ((shortestDistance + edgeDistance) < outputs[0][vIndex])) {
          outputs[0][vIndex] = shortestDistance + edgeDistance;
          outputs[1][vIndex] = nearestVertex;
        }
      }
    }

    return outputs;
  }
}