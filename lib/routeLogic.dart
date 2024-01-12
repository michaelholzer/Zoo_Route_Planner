class DijkstrasAlgorithm {

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
  // amount of locations in the matrix
  static int amount = adjacencyMatrix.length;
  int getAmount () => amount;

  // to be edited by starting location
  int start = 0;
  void setStart (int value) => start = value; // may change to string
  // int getStart () => start;

  // if animal selected is true
  List<bool> toVisit = List.filled(amount, false);
  void setState (int index, bool state) => toVisit[index] = state;
  // bool getState (int index) => toVisit[index];
  void setVisitState(List<bool> visits) => toVisit = visits;

  List locationOrder = [];
  void setLocationOrder(List<int> order) => locationOrder = order;
  // String getLocationOrder(int index) => locationOrder[index].toString();
  // int getOrderAmount() => locationOrder.length;
  List getFullOrder () => locationOrder;

  void runAlgorithm () {
    // starting location is visited
    toVisit[start] = false;
    // add start location to beginning of list
    List<int> finalList = [start];
    // add the rest of the steps
    finalList.addAll(_recursiveSearch(adjacencyMatrix, start, toVisit));
    setLocationOrder(finalList);
  }
  
  List<int> _recursiveSearch (List<List<int>> graph, int start, List<bool> checks) {
    List<int> path = [];
    
    List<List<int>> solutions = _dijkstra(graph, start);

    // current vertex no longer needed to be visited
    checks[start] = false;
    int nextVertex = _minDistance(solutions[0], checks);
    path.add(nextVertex);
    // ****NEED TO IMPLEMENT TO SHOW FULL STEPS****
    // path.addAll(_fullPath(nextVertex, solutions[1], start));

    if (_allVisited(checks)) {
      return path;
    } else {
      path.addAll(_recursiveSearch(graph, nextVertex, checks));
    }
    
    return path;
  }

  int _minDistance (List<int> distance, List<bool> toSee) {
    // initialize min value to largest value possible
    int min = 0x7FFFFFFFFFFFFFFF;
    int minIndex = -1;

    for (int i = 0; i < distance.length; i++) {
      if (toSee[i] == true && distance[i] <= min) {
        min = distance[i];
        minIndex = i;
      }
    }

    return minIndex;
  }

  bool _allVisited (List<bool> toSee) {
    for (int i = 0; i < toSee.length; i++) {
      // if any need to be seen, return false
      if (toSee[i]) return false;
    }
    // if all have been seen, return true
    return true;
  }

  // List<int> _fullPath (int currentVertex, List<int> parents, start) {
  //   List<int> list = [currentVertex];
  //   if (currentVertex == start) {
  //     return list;
  //   }
  //   list.addAll(_fullPath(parents[currentVertex], parents, start));
  //   return list;
  // }

  List<List<int>> _dijkstra (List<List<int>> graph, int start) {
    // output list with two rows and one column per location in adjacency matrix
    // row 0 holds shortest distance to each vertex from the source
    // row 1 holds shortest path tree
    List<List<int>> outputs = List<List>.generate(2, (i) => List<int>.generate(amount, (index) => 0x7FFFFFFFFFFFFFFF, growable: false), growable: false).cast<List<int>>();

    // added array checks if each vertex is included
    List<bool> added = List<bool>.generate(amount, (index) => false);

    // start vertex distance is 0 and has no parent (-1)
    outputs[0][start] = 0;
    outputs[1][start] = -1;

    // find shortest path for all vertices
    for (int i = 1; i < amount; i++) {

      int nearestVertex = -1;
      int shortestDistance = 0x7FFFFFFFFFFFFFFF;

      for (int vIndex = 0; vIndex < amount; vIndex++) {
        if (!added[vIndex] && outputs[0][vIndex] < shortestDistance) {
          nearestVertex = vIndex;
          shortestDistance = outputs[0][vIndex];
        }
      }

      // nearest vertex is processed
      added[nearestVertex];

      // update distance value of adjacent vertices
      for (int vIndex = 0; vIndex < amount; vIndex++) {
        int edgeDistance = graph[nearestVertex][vIndex];

        if (edgeDistance > 0 && ((shortestDistance + edgeDistance) < outputs[0][vIndex])) {
          outputs[0][vIndex] = shortestDistance + edgeDistance;
          outputs[1][vIndex] = nearestVertex;
        }
      }
    }

    return outputs;
  }
}