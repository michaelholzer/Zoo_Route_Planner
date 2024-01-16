class DijkstrasAlgorithm {

  /// List of names for all items
  /// New ones will be added in correct alphabetical order
  static final List<String> names = [
    'Andean Bear', 'Axolotl',                                                   /// 'A'
    'Bashur Bridge Elevator',                                                   /// 'B'
    'California Condor', 'Cheetah',                                             /// 'C'
    /// 'D'
    'Elephant', 'Entrance', 'Exit',                                             /// 'E'
    'Fern Canyon',                                                              /// 'F'
    'Galapagos Tortoise', 'Giraffe', 'Gorilla',                                 /// 'G'
    'Hamadryas Baboon', 'Harpy Eagle', 'Hummingbird',                           /// 'H'
    /// 'I', 'J'
    'Kangaroo Stop 1', 'Kangaroo Stop 3', 'Koala', 'Komodo Dragon',             /// 'K'
    'Lemur', 'Leopard', 'Lion',                                                 /// 'L'
    'Mandrill', 'Map Locator 03', 'Map Locator 04', 'Map Locator 08', 'Map Locator 11',
    'Map Locator 13', 'Map Locator 15', 'Map Locator 20', 'Merekat',            /// 'M'
    /// 'N'
    'Orangutan',                                                                /// 'O'
    'Penguin', 'Polar Bear',                                                    /// 'P'
    /// 'Q'
    'Red Panda',                                                                /// 'R'
    'Safari Kitchen',                                                           /// 'S'
    'Tasmanian Devil', 'Tiger',                                                 /// 'T'
    /// 'U', 'V', 'W', 'X', 'Y'
    'Zebra',                                                                    /// 'Z'
  ];
  String getName (int index) {
    if (index == -1) {
      return "Destination Reached";
    } else {
      return names[index];
    }
  }
  List<String> getAllNames () => names;
  int returnIndex (String name) => names.indexOf(name);

  /// Amount of locations in the lists
  static int amount = names.length;
  int getAmount () => amount;

  /// Generate lists of all 0s for coordinates and adjacency
  List<List<double>> coordinates = List<List>.generate(amount, (i) => List<int>.generate(2, (index) => 0, growable: false), growable: false).cast<List<double>>();
  List<List<int>> adjacencyMatrix = List<List>.generate(amount, (i) => List<int>.generate(amount, (index) => 0, growable: false), growable: false).cast<List<int>>();
  List<List<String>> directionMatrix = List<List>.generate(amount, (i) => List<String>.generate(amount, (index) => '', growable: false), growable: false).cast<List<String>>();
  List<bool> animal = List<bool>.generate(amount, (index) => true);

  /// The called function to set the data for coordinates and adjacency
  /// This allows for future additions to be made seamlessly once a name has
  ///   been added into the name list
  void assignData() {
    /// Set the Coordinate data
    coordinates[names.indexOf('Andean Bear')] = [32.73625, -117.15013];
    coordinates[names.indexOf('Axolotl')] = [32.73329, -117.14888];
    coordinates[names.indexOf('Bashur Bridge Elevator')] = [32.73514, -117.15202];
    coordinates[names.indexOf('California Condor')] = [32.73912, -117.15161];
    coordinates[names.indexOf('Cheetah')] = [32.73728, -117.15064];
    coordinates[names.indexOf('Elephant')] = [32.73747, -117.15346];
    coordinates[names.indexOf('Entrance')] = [32.73520, -117.14950];
    coordinates[names.indexOf('Exit')] = [32.73467, -117.14940];
    coordinates[names.indexOf('Fern Canyon')] = [32.73529, -117.14997];
    coordinates[names.indexOf('Galapagos Tortoise')] =  [32.73352, -117.15026];
    coordinates[names.indexOf('Giraffe')] = [32.73686, -117.15043];
    coordinates[names.indexOf('Gorilla')] = [32.73473, -117.15122];
    coordinates[names.indexOf('Hamadryas Baboon')] = [32.73865, -117.15008];
    coordinates[names.indexOf('Harpy Eagle')] = [32.73385, -117.15377];
    coordinates[names.indexOf('Hummingbird')] = [32.73372, -117.14928];
    coordinates[names.indexOf('Kangaroo Stop 1')] = [32.73728, -117.15021];
    coordinates[names.indexOf('Kangaroo Stop 3')] = [32.73538, -117.15339];
    coordinates[names.indexOf('Koala')] = [32.73766, -117.15014];
    coordinates[names.indexOf('Komodo Dragon')] = [32.73392, -117.14935];
    coordinates[names.indexOf('Lemur')] = [32.73749, -117.15170];
    coordinates[names.indexOf('Leopard')] = [32.73430, -117.15328];
    coordinates[names.indexOf('Lion')] = [32.73594, -117.15303];
    coordinates[names.indexOf('Mandrill')] = [32.73506, -117.15070];
    coordinates[names.indexOf('Map Locator 03')] = [32.73452, -117.14953];
    coordinates[names.indexOf('Map Locator 04')] = [32.73519, -117.14974];
    coordinates[names.indexOf('Map Locator 08')] = [32.73752, -117.14944];
    coordinates[names.indexOf('Map Locator 11')] = [32.73597, -117.15040];
    coordinates[names.indexOf('Map Locator 13')] = [32.73576, -117.15173];
    coordinates[names.indexOf('Map Locator 15')] = [32.73404, -117.15336];
    coordinates[names.indexOf('Map Locator 20')] = [32.73553, -117.15289];
    coordinates[names.indexOf('Merekat')] = [32.73929, -117.15060];
    coordinates[names.indexOf('Orangutan')] = [32.73540, -117.15058];
    coordinates[names.indexOf('Penguin')] = [32.73638, -117.15201];
    coordinates[names.indexOf('Polar Bear')] = [32.73430, -117.15469];
    coordinates[names.indexOf('Red Panda')] = [32.73506, -117.15228];
    coordinates[names.indexOf('Safari Kitchen')] = [32.73481, -117.14973];
    coordinates[names.indexOf('Tasmanian Devil')] = [32.73753, -117.14911];
    coordinates[names.indexOf('Tiger')] = [32.73390, -117.15113];
    coordinates[names.indexOf('Zebra')] = [32.73379, -117.15474];

    /// Set the Adjacency Values
    adjacencyMatrix[names.indexOf('Andean Bear')][names.indexOf('Map Locator 08')] = 166;
    adjacencyMatrix[names.indexOf('Andean Bear')][names.indexOf('Map Locator 11')] = 43;
    adjacencyMatrix[names.indexOf('Axolotl')][names.indexOf('Hummingbird')] = 67;
    adjacencyMatrix[names.indexOf('Bashur Bridge Elevator')][names.indexOf('Gorilla')] = 100;
    adjacencyMatrix[names.indexOf('Bashur Bridge Elevator')][names.indexOf('Red Panda')] = 40;
    adjacencyMatrix[names.indexOf('Bashur Bridge Elevator')][names.indexOf('Map Locator 20')] = 90;
    adjacencyMatrix[names.indexOf('California Condor')][names.indexOf('Merekat')] = 105;
    adjacencyMatrix[names.indexOf('California Condor')][names.indexOf('Elephant')] = 313;
    adjacencyMatrix[names.indexOf('Cheetah')][names.indexOf('Giraffe')] = 42;
    adjacencyMatrix[names.indexOf('Cheetah')][names.indexOf('Kangaroo Stop 1')] = 41;
    adjacencyMatrix[names.indexOf('Elephant')][names.indexOf('California Condor')] = 313;
    adjacencyMatrix[names.indexOf('Elephant')][names.indexOf('Lion')] = 187;
    adjacencyMatrix[names.indexOf('Entrance')][names.indexOf('Tasmanian Devil')] = 281;
    adjacencyMatrix[names.indexOf('Entrance')][names.indexOf('Map Locator 04')] = 19;
    adjacencyMatrix[names.indexOf('Exit')][names.indexOf('Safari Kitchen')] = 37;
    adjacencyMatrix[names.indexOf('Exit')][names.indexOf('Map Locator 03')] = 21;
    adjacencyMatrix[names.indexOf('Fern Canyon')][names.indexOf('Orangutan')] = 35;
    adjacencyMatrix[names.indexOf('Fern Canyon')][names.indexOf('Map Locator 11')] = 85;
    adjacencyMatrix[names.indexOf('Fern Canyon')][names.indexOf('Map Locator 04')] = 40;
    adjacencyMatrix[names.indexOf('Galapagos Tortoise')][names.indexOf('Map Locator 03')] = 121;
    adjacencyMatrix[names.indexOf('Galapagos Tortoise')][names.indexOf('Komodo Dragon')] = 101;
    adjacencyMatrix[names.indexOf('Giraffe')][names.indexOf('Cheetah')] = 42;
    adjacencyMatrix[names.indexOf('Giraffe')][names.indexOf('Kangaroo Stop 1')] = 47;
    adjacencyMatrix[names.indexOf('Gorilla')][names.indexOf('Orangutan')] = 140;
    adjacencyMatrix[names.indexOf('Gorilla')][names.indexOf('Bashur Bridge Elevator')] = 100;
    adjacencyMatrix[names.indexOf('Gorilla')][names.indexOf('Mandrill')] = 117;
    adjacencyMatrix[names.indexOf('Hamadryas Baboon')][names.indexOf('Lemur')] = 276;
    adjacencyMatrix[names.indexOf('Hamadryas Baboon')][names.indexOf('Merekat')] = 153;
    adjacencyMatrix[names.indexOf('Hamadryas Baboon')][names.indexOf('Koala')] = 121;
    adjacencyMatrix[names.indexOf('Harpy Eagle')][names.indexOf('Zebra')] = 91;
    adjacencyMatrix[names.indexOf('Harpy Eagle')][names.indexOf('Map Locator 15')] = 48;
    adjacencyMatrix[names.indexOf('Hummingbird')][names.indexOf('Axolotl')] = 67;
    adjacencyMatrix[names.indexOf('Hummingbird')][names.indexOf('Komodo Dragon')] = 23;
    adjacencyMatrix[names.indexOf('Kangaroo Stop 1')][names.indexOf('Cheetah')] = 41;
    adjacencyMatrix[names.indexOf('Kangaroo Stop 1')][names.indexOf('Giraffe')] = 47;
    adjacencyMatrix[names.indexOf('Kangaroo Stop 1')][names.indexOf('Koala')] = 58;
    adjacencyMatrix[names.indexOf('Kangaroo Stop 3')][names.indexOf('Polar Bear')] = 207;
    adjacencyMatrix[names.indexOf('Kangaroo Stop 3')][names.indexOf('Map Locator 20')] = 40;
    adjacencyMatrix[names.indexOf('Koala')][names.indexOf('Hamadryas Baboon')] = 121;
    adjacencyMatrix[names.indexOf('Koala')][names.indexOf('Kangaroo Stop 1')] = 58;
    adjacencyMatrix[names.indexOf('Koala')][names.indexOf('Map Locator 08')] = 93;
    adjacencyMatrix[names.indexOf('Komodo Dragon')][names.indexOf('Galapagos Tortoise')] = 101;
    adjacencyMatrix[names.indexOf('Komodo Dragon')][names.indexOf('Hummingbird')] = 23;
    adjacencyMatrix[names.indexOf('Komodo Dragon')][names.indexOf('Map Locator 03')] = 70;
    adjacencyMatrix[names.indexOf('Lemur')][names.indexOf('Hamadryas Baboon')] = 276;
    adjacencyMatrix[names.indexOf('Lemur')][names.indexOf('Penguin')] = 194;
    adjacencyMatrix[names.indexOf('Leopard')][names.indexOf('Map Locator 15')] = 46;
    adjacencyMatrix[names.indexOf('Leopard')][names.indexOf('Red Panda')] = 50;
    adjacencyMatrix[names.indexOf('Lion')][names.indexOf('Elephant')] = 187;
    adjacencyMatrix[names.indexOf('Lion')][names.indexOf('Map Locator 20')] = 50;
    adjacencyMatrix[names.indexOf('Mandrill')][names.indexOf('Gorilla')] = 117;
    adjacencyMatrix[names.indexOf('Mandrill')][names.indexOf('Tiger')] = 217;
    adjacencyMatrix[names.indexOf('Mandrill')][names.indexOf('Orangutan')] = 117;
    adjacencyMatrix[names.indexOf('Mandrill')][names.indexOf('Safari Kitchen')] = 132;
    adjacencyMatrix[names.indexOf('Map Locator 03')][names.indexOf('Galapagos Tortoise')] = 121;
    adjacencyMatrix[names.indexOf('Map Locator 03')][names.indexOf('Komodo Dragon')] = 70;
    adjacencyMatrix[names.indexOf('Map Locator 03')][names.indexOf('Exit')] = 21;
    adjacencyMatrix[names.indexOf('Map Locator 04')][names.indexOf('Safari Kitchen')] = 40;
    adjacencyMatrix[names.indexOf('Map Locator 04')][names.indexOf('Fern Canyon')] = 30;
    adjacencyMatrix[names.indexOf('Map Locator 04')][names.indexOf('Entrance')] = 19;
    adjacencyMatrix[names.indexOf('Map Locator 08')][names.indexOf('Andean Bear')] = 166;
    adjacencyMatrix[names.indexOf('Map Locator 08')][names.indexOf('Koala')] = 93;
    adjacencyMatrix[names.indexOf('Map Locator 08')][names.indexOf('Tasmanian Devil')] = 28;
    adjacencyMatrix[names.indexOf('Map Locator 11')][names.indexOf('Andean Bear')] = 43;
    adjacencyMatrix[names.indexOf('Map Locator 11')][names.indexOf('Fern Canyon')] = 85;
    adjacencyMatrix[names.indexOf('Map Locator 11')][names.indexOf('Map Locator 13')] = 121;
    adjacencyMatrix[names.indexOf('Map Locator 13')][names.indexOf('Map Locator 11')] = 121;
    adjacencyMatrix[names.indexOf('Map Locator 13')][names.indexOf('Penguin')] = 87;
    adjacencyMatrix[names.indexOf('Map Locator 13')][names.indexOf('Red Panda')] = 87;
    adjacencyMatrix[names.indexOf('Map Locator 15')][names.indexOf('Harpy Eagle')] = 48;
    adjacencyMatrix[names.indexOf('Map Locator 15')][names.indexOf('Leopard')] = 46;
    adjacencyMatrix[names.indexOf('Map Locator 15')][names.indexOf('Tiger')] = 168;
    adjacencyMatrix[names.indexOf('Map Locator 20')][names.indexOf('Lion')] = 45;
    adjacencyMatrix[names.indexOf('Map Locator 20')][names.indexOf('Bashur Bridge Elevator')] = 90;
    adjacencyMatrix[names.indexOf('Map Locator 20')][names.indexOf('Kangaroo Stop 3')] = 40;
    adjacencyMatrix[names.indexOf('Merekat')][names.indexOf('Hamadryas Baboon')] = 153;
    adjacencyMatrix[names.indexOf('Merekat')][names.indexOf('California Condor')] = 105;
    adjacencyMatrix[names.indexOf('Orangutan')][names.indexOf('Fern Canyon')] = 35;
    adjacencyMatrix[names.indexOf('Orangutan')][names.indexOf('Mandrill')] = 117;
    adjacencyMatrix[names.indexOf('Orangutan')][names.indexOf('Gorilla')] = 140;
    adjacencyMatrix[names.indexOf('Penguin')][names.indexOf('Lemur')] = 194;
    adjacencyMatrix[names.indexOf('Penguin')][names.indexOf('Map Locator 13')] = 87;
    adjacencyMatrix[names.indexOf('Polar Bear')][names.indexOf('Zebra')] = 71;
    adjacencyMatrix[names.indexOf('Polar Bear')][names.indexOf('Kangaroo Stop 3')] = 207;
    adjacencyMatrix[names.indexOf('Red Panda')][names.indexOf('Leopard')] = 50;
    adjacencyMatrix[names.indexOf('Red Panda')][names.indexOf('Bashur Bridge Elevator')] = 40;
    adjacencyMatrix[names.indexOf('Red Panda')][names.indexOf('Map Locator 13')] = 40;
    adjacencyMatrix[names.indexOf('Safari Kitchen')][names.indexOf('Exit')] = 37;
    adjacencyMatrix[names.indexOf('Safari Kitchen')][names.indexOf('Map Locator 04')] = 40;
    adjacencyMatrix[names.indexOf('Safari Kitchen')][names.indexOf('Mandrill')] = 132;
    adjacencyMatrix[names.indexOf('Tasmanian Devil')][names.indexOf('Entrance')] = 281;
    adjacencyMatrix[names.indexOf('Tasmanian Devil')][names.indexOf('Map Locator 08')] = 28;
    adjacencyMatrix[names.indexOf('Tiger')][names.indexOf('Map Locator 15')] = 28;
    adjacencyMatrix[names.indexOf('Tiger')][names.indexOf('Mandrill')] = 217;
    adjacencyMatrix[names.indexOf('Zebra')][names.indexOf('Polar Bear')] = 71;
    adjacencyMatrix[names.indexOf('Zebra')][names.indexOf('Harpy Eagle')] = 91;

    /// Set Matrix to give Directions
    directionMatrix[names.indexOf('Andean Bear')][names.indexOf('Map Locator 08')]
      = 'Walk up the hill.';
    directionMatrix[names.indexOf('Andean Bear')][names.indexOf('Map Locator 11')]
      = 'Walk down the hill.';
    directionMatrix[names.indexOf('Axolotl')][names.indexOf('Hummingbird')]
      = 'Walk towards the exit of Wildlife Explorer\'s Basecamp. Turn left after exiting.';
    directionMatrix[names.indexOf('Bashur Bridge Elevator')][names.indexOf('Gorilla')]
      = 'Walk away from the bridge and follow the path to the right.';
    directionMatrix[names.indexOf('Bashur Bridge Elevator')][names.indexOf('Red Panda')]
      = 'Take the elevator or stairs down an go left.';
    directionMatrix[names.indexOf('Bashur Bridge Elevator')][names.indexOf('Map Locator 20')]
      = 'Walk across the bridge.';
    directionMatrix[names.indexOf('California Condor')][names.indexOf('Merekat')]
      = 'Walk towards the road and follow the pedestrian path to the right.';
    directionMatrix[names.indexOf('California Condor')][names.indexOf('Elephant')]
      = 'Walk away from the road and follow the path.';
    directionMatrix[names.indexOf('Cheetah')][names.indexOf('Giraffe')]
      = 'Walk around the center island.';
    directionMatrix[names.indexOf('Cheetah')][names.indexOf('Kangaroo Stop 1')]
      = 'Walk towards the center island with the Kangaroo bus sign.';
    directionMatrix[names.indexOf('Elephant')][names.indexOf('California Condor')]
      = 'Continue down the path with the road to your left.';
    directionMatrix[names.indexOf('Elephant')][names.indexOf('Lion')]
      = 'Continue down the path with the road to your right.';
    directionMatrix[names.indexOf('Entrance')][names.indexOf('Tasmanian Devil')]
      = 'Turn with the entrance on the right and road on the left. Follow the winding path shadowed by trees.';
    directionMatrix[names.indexOf('Entrance')][names.indexOf('Map Locator 04')]
      = 'Cross the road to the circular sign on a signpost.';
    directionMatrix[names.indexOf('Exit')][names.indexOf('Safari Kitchen')] = '37';
    directionMatrix[names.indexOf('Exit')][names.indexOf('Map Locator 03')] = '21';
    directionMatrix[names.indexOf('Fern Canyon')][names.indexOf('Orangutan')] = '35';
    directionMatrix[names.indexOf('Fern Canyon')][names.indexOf('Map Locator 11')] = '85';
    directionMatrix[names.indexOf('Fern Canyon')][names.indexOf('Map Locator 04')] = '40';
    directionMatrix[names.indexOf('Galapagos Tortoise')][names.indexOf('Map Locator 03')] = '121';
    directionMatrix[names.indexOf('Galapagos Tortoise')][names.indexOf('Komodo Dragon')] = '101';
    directionMatrix[names.indexOf('Giraffe')][names.indexOf('Cheetah')] = '42';
    directionMatrix[names.indexOf('Giraffe')][names.indexOf('Kangaroo Stop 1')] = '47';
    directionMatrix[names.indexOf('Gorilla')][names.indexOf('Orangutan')] = '140';
    directionMatrix[names.indexOf('Gorilla')][names.indexOf('Bashur Bridge Elevator')] = '100';
    directionMatrix[names.indexOf('Gorilla')][names.indexOf('Mandrill')] = '117';
    directionMatrix[names.indexOf('Hamadryas Baboon')][names.indexOf('Lemur')] = '276';
    directionMatrix[names.indexOf('Hamadryas Baboon')][names.indexOf('Merekat')] = '153';
    directionMatrix[names.indexOf('Hamadryas Baboon')][names.indexOf('Koala')] = '121';
    directionMatrix[names.indexOf('Harpy Eagle')][names.indexOf('Zebra')] = '91';
    directionMatrix[names.indexOf('Harpy Eagle')][names.indexOf('Map Locator 15')] = '48';
    directionMatrix[names.indexOf('Hummingbird')][names.indexOf('Axolotl')] = '67';
    directionMatrix[names.indexOf('Hummingbird')][names.indexOf('Komodo Dragon')] = '23';
    directionMatrix[names.indexOf('Kangaroo Stop 1')][names.indexOf('Cheetah')] = '41';
    directionMatrix[names.indexOf('Kangaroo Stop 1')][names.indexOf('Giraffe')] = '47';
    directionMatrix[names.indexOf('Kangaroo Stop 1')][names.indexOf('Koala')] = '58';
    directionMatrix[names.indexOf('Kangaroo Stop 3')][names.indexOf('Polar Bear')] = '207';
    directionMatrix[names.indexOf('Kangaroo Stop 3')][names.indexOf('Map Locator 20')] = '40';
    directionMatrix[names.indexOf('Koala')][names.indexOf('Hamadryas Baboon')] = '121';
    directionMatrix[names.indexOf('Koala')][names.indexOf('Kangaroo Stop 1')] = '58';
    directionMatrix[names.indexOf('Koala')][names.indexOf('Map Locator 08')] = '93';
    directionMatrix[names.indexOf('Komodo Dragon')][names.indexOf('Galapagos Tortoise')] = '101';
    directionMatrix[names.indexOf('Komodo Dragon')][names.indexOf('Hummingbird')] = '23';
    directionMatrix[names.indexOf('Komodo Dragon')][names.indexOf('Map Locator 03')] = '70';
    directionMatrix[names.indexOf('Lemur')][names.indexOf('Hamadryas Baboon')] = '276';
    directionMatrix[names.indexOf('Lemur')][names.indexOf('Penguin')] = '194';
    directionMatrix[names.indexOf('Leopard')][names.indexOf('Map Locator 15')] = '46';
    directionMatrix[names.indexOf('Leopard')][names.indexOf('Red Panda')] = '50';
    directionMatrix[names.indexOf('Lion')][names.indexOf('Elephant')] = '187';
    directionMatrix[names.indexOf('Lion')][names.indexOf('Map Locator 20')] = '50';
    directionMatrix[names.indexOf('Mandrill')][names.indexOf('Gorilla')] = '117';
    directionMatrix[names.indexOf('Mandrill')][names.indexOf('Tiger')] = '217';
    directionMatrix[names.indexOf('Mandrill')][names.indexOf('Orangutan')] = '117';
    directionMatrix[names.indexOf('Mandrill')][names.indexOf('Safari Kitchen')] = '132';
    directionMatrix[names.indexOf('Map Locator 03')][names.indexOf('Galapagos Tortoise')] = '121';
    directionMatrix[names.indexOf('Map Locator 03')][names.indexOf('Komodo Dragon')] = '70';
    directionMatrix[names.indexOf('Map Locator 03')][names.indexOf('Exit')] = '21';
    directionMatrix[names.indexOf('Map Locator 04')][names.indexOf('Safari Kitchen')] = '40';
    directionMatrix[names.indexOf('Map Locator 04')][names.indexOf('Fern Canyon')] = '30';
    directionMatrix[names.indexOf('Map Locator 04')][names.indexOf('Entrance')] = '19';
    directionMatrix[names.indexOf('Map Locator 08')][names.indexOf('Andean Bear')] = '166';
    directionMatrix[names.indexOf('Map Locator 08')][names.indexOf('Koala')] = '93';
    directionMatrix[names.indexOf('Map Locator 08')][names.indexOf('Tasmanian Devil')] = '28';
    directionMatrix[names.indexOf('Map Locator 11')][names.indexOf('Andean Bear')] = '43';
    directionMatrix[names.indexOf('Map Locator 11')][names.indexOf('Fern Canyon')] = '85';
    directionMatrix[names.indexOf('Map Locator 11')][names.indexOf('Map Locator 13')] = '121';
    directionMatrix[names.indexOf('Map Locator 13')][names.indexOf('Map Locator 11')] = '121';
    directionMatrix[names.indexOf('Map Locator 13')][names.indexOf('Penguin')] = '87';
    directionMatrix[names.indexOf('Map Locator 13')][names.indexOf('Red Panda')] = '87';
    directionMatrix[names.indexOf('Map Locator 15')][names.indexOf('Harpy Eagle')] = '48';
    directionMatrix[names.indexOf('Map Locator 15')][names.indexOf('Leopard')] = '46';
    directionMatrix[names.indexOf('Map Locator 15')][names.indexOf('Tiger')] = '168';
    directionMatrix[names.indexOf('Map Locator 20')][names.indexOf('Lion')] = '45';
    directionMatrix[names.indexOf('Map Locator 20')][names.indexOf('Bashur Bridge Elevator')] = '90';
    directionMatrix[names.indexOf('Map Locator 20')][names.indexOf('Kangaroo Stop 3')] = '40';
    directionMatrix[names.indexOf('Merekat')][names.indexOf('Hamadryas Baboon')] = '153';
    directionMatrix[names.indexOf('Merekat')][names.indexOf('California Condor')] = '105';
    directionMatrix[names.indexOf('Orangutan')][names.indexOf('Fern Canyon')] = '35';
    directionMatrix[names.indexOf('Orangutan')][names.indexOf('Mandrill')] = '117';
    directionMatrix[names.indexOf('Orangutan')][names.indexOf('Gorilla')] = '140';
    directionMatrix[names.indexOf('Penguin')][names.indexOf('Lemur')] = '194';
    directionMatrix[names.indexOf('Penguin')][names.indexOf('Map Locator 13')] = '87';
    directionMatrix[names.indexOf('Polar Bear')][names.indexOf('Zebra')] = '71';
    directionMatrix[names.indexOf('Polar Bear')][names.indexOf('Kangaroo Stop 3')] = '207';
    directionMatrix[names.indexOf('Red Panda')][names.indexOf('Leopard')] = '50';
    directionMatrix[names.indexOf('Red Panda')][names.indexOf('Bashur Bridge Elevator')] = '40';
    directionMatrix[names.indexOf('Red Panda')][names.indexOf('Map Locator 13')] = '40';
    directionMatrix[names.indexOf('Safari Kitchen')][names.indexOf('Exit')] = '37';
    directionMatrix[names.indexOf('Safari Kitchen')][names.indexOf('Map Locator 04')] = '40';
    directionMatrix[names.indexOf('Safari Kitchen')][names.indexOf('Mandrill')] = '132';
    directionMatrix[names.indexOf('Tasmanian Devil')][names.indexOf('Entrance')] = '281';
    directionMatrix[names.indexOf('Tasmanian Devil')][names.indexOf('Map Locator 08')] = '28';
    directionMatrix[names.indexOf('Tiger')][names.indexOf('Map Locator 15')] = '28';
    directionMatrix[names.indexOf('Tiger')][names.indexOf('Mandrill')] = '217';
    directionMatrix[names.indexOf('Zebra')][names.indexOf('Polar Bear')] = '71';
    directionMatrix[names.indexOf('Zebra')][names.indexOf('Harpy Eagle')] = '91';

    /// Set non-animal locations as false
    animal[names.indexOf('Bashur Bridge Elevator')] = false;
    animal[names.indexOf('Entrance')] = false;
    animal[names.indexOf('Exit')] = false;
    animal[names.indexOf('Fern Canyon')] = false;
    animal[names.indexOf('Kangaroo Stop 1')] = false;
    animal[names.indexOf('Kangaroo Stop 3')] = false;
    animal[names.indexOf('Map Locator 03')] = false;
    animal[names.indexOf('Map Locator 04')] = false;
    animal[names.indexOf('Map Locator 08')] = false;
    animal[names.indexOf('Map Locator 11')] = false;
    animal[names.indexOf('Map Locator 13')] = false;
    animal[names.indexOf('Map Locator 15')] = false;
    animal[names.indexOf('Map Locator 20')] = false;
    animal[names.indexOf('Safari Kitchen')] = false;
  }

  /// Access the individual coordinate values
  double getXCoordinate (int index) => coordinates[index][0];
  double getYCoordinate (int index) => coordinates[index][1];

  /// Return true if there is a connection between two locations
  bool pointsConnect (int one, int two) => (adjacencyMatrix[one][two] > 0);

  /// Returns directions
  String getDirection (int one, int two) {
    if (one == -2 || two == -2) {
      return 'You have arrived at your final planned destination!';
    } else {
      return (directionMatrix[one][two]);
    }
  }

  /// Return animal status
  bool isAnimal (int index) => animal[index];

  /// Starting location
  int start = 0;
  void setStart (int value) => start = value;

  /// True if user wants to visit the animal
  List<bool> toVisit = List.filled(amount, false);
  void setState (int index, bool state) => toVisit[index] = state;
  void setVisitState(List<bool> visits) => toVisit = visits;

  /// The outputted list of animals in shortest order
  List locationOrder = [];
  void setLocationOrder(List<int> order) => locationOrder = order;
  List getFullOrder () => locationOrder;

  /// Returns the shortest path tree
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