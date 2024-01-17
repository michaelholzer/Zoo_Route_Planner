class DijkstrasAlgorithm {

  /// List of names for all items
  /// This list needs to be kept in alphabetical order
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
    'Map Locator 13', 'Map Locator 15', 'Map Locator 20', 'Meerkat',            /// 'M'
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
    coordinates[names.indexOf('Meerkat')] = [32.73929, -117.15060];
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
    adjacencyMatrix[names.indexOf('California Condor')][names.indexOf('Meerkat')] = 105;
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
    adjacencyMatrix[names.indexOf('Hamadryas Baboon')][names.indexOf('Meerkat')] = 153;
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
    adjacencyMatrix[names.indexOf('Meerkat')][names.indexOf('Hamadryas Baboon')] = 153;
    adjacencyMatrix[names.indexOf('Meerkat')][names.indexOf('California Condor')] = 105;
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
      = 'Walk up the hill to the red circular sign on a signpost, Map Locator 08.';
    directionMatrix[names.indexOf('Andean Bear')][names.indexOf('Map Locator 11')]
      = 'Walk down the hill to the red circular sign on a signpost, Map Locator 11.';
    directionMatrix[names.indexOf('Axolotl')][names.indexOf('Hummingbird')]
      = 'Walk towards the exit of Wildlife Explorer\'s Basecamp. Turn left after exiting and arrive at the Hummingbird Aviary.';
    directionMatrix[names.indexOf('Bashur Bridge Elevator')][names.indexOf('Gorilla')]
      = 'Walk away from the bridge and follow the path to the right to the gorillas.';
    directionMatrix[names.indexOf('Bashur Bridge Elevator')][names.indexOf('Red Panda')]
      = 'Take the elevator or stairs down an go left to the Red Pandas.';
    directionMatrix[names.indexOf('Bashur Bridge Elevator')][names.indexOf('Map Locator 20')]
      = 'Walk across the bridge to the red circular sign on a signpost, Map Locator 20.';
    directionMatrix[names.indexOf('California Condor')][names.indexOf('Meerkat')]
      = 'Walk towards the bus road and follow the pedestrian path to the right to reach the meerkat habitat.';
    directionMatrix[names.indexOf('California Condor')][names.indexOf('Elephant')]
      = 'Walk away from the bus road and follow the path to the elephants.';
    directionMatrix[names.indexOf('Cheetah')][names.indexOf('Giraffe')]
      = 'Walk to the opposite side of the center island and arrive at the giraffes.';
    directionMatrix[names.indexOf('Cheetah')][names.indexOf('Kangaroo Stop 1')]
      = 'Walk towards the center island with the Kangaroo bus sign.';
    directionMatrix[names.indexOf('Elephant')][names.indexOf('California Condor')]
      = 'Continue down the path with the road to your left until you reach the California Condors.';
    directionMatrix[names.indexOf('Elephant')][names.indexOf('Lion')]
      = 'Continue down the path with the road to your right and arrive at the Lions.';
    directionMatrix[names.indexOf('Entrance')][names.indexOf('Tasmanian Devil')]
      = 'Turn with the entrance on the right and road on the left. Follow the winding path shadowed by trees to arrive at the Tasmanian Devil habitat.';
    directionMatrix[names.indexOf('Entrance')][names.indexOf('Map Locator 04')]
      = 'Cross the road to the red circular sign on a signpost, Map Locator 04.';
    directionMatrix[names.indexOf('Exit')][names.indexOf('Safari Kitchen')]
      = 'Facing the exit (the direction of the macaw), turn left and follow the path to Safari Kitchen.';
    directionMatrix[names.indexOf('Exit')][names.indexOf('Map Locator 03')]
      = 'Facing the exit (the direction of the macaw), turn right to the red circular sign on a signpost, Map Locator 03.';
    directionMatrix[names.indexOf('Fern Canyon')][names.indexOf('Orangutan')]
      = 'From the top of Fern Canyon, turn right and follow the path on the right to reach the orangutan habitat.';
    directionMatrix[names.indexOf('Fern Canyon')][names.indexOf('Map Locator 11')]
      = 'Walk down Fern Canyon to the red circular sign on a signpost, Map Locator 11.';
    directionMatrix[names.indexOf('Fern Canyon')][names.indexOf('Map Locator 04')]
      = 'From the top of Fern Canyon, turn left and follow the path to the red circular sign on a signpost, Map Locator 04.';
    directionMatrix[names.indexOf('Galapagos Tortoise')][names.indexOf('Map Locator 03')]
      = 'Leave Reptile Mesa and go left around the Reptile House to the red circular sign on a signpost, Map Locator 03.';
    directionMatrix[names.indexOf('Galapagos Tortoise')][names.indexOf('Komodo Dragon')]
      = 'Leave Reptile Mesa and go right around the Reptile House to Komodo Kingdom.';
    directionMatrix[names.indexOf('Giraffe')][names.indexOf('Cheetah')]
      = 'Walk to the opposite side of the center island to the cheetah habitat.';
    directionMatrix[names.indexOf('Giraffe')][names.indexOf('Kangaroo Stop 1')]
      = 'Walk towards the center island with the Kangaroo bus sign.';
    directionMatrix[names.indexOf('Gorilla')][names.indexOf('Orangutan')]
      = 'Facing the gorillas, turn right and follow the left path to the orangutan habitat.';
    directionMatrix[names.indexOf('Gorilla')][names.indexOf('Bashur Bridge Elevator')]
      = 'Facing the gorillas, turn left and walk to the bridge.';
    directionMatrix[names.indexOf('Gorilla')][names.indexOf('Mandrill')]
      = 'Facing the gorillas, turn right and follow the right path to the mandrill habitat.';
    directionMatrix[names.indexOf('Hamadryas Baboon')][names.indexOf('Lemur')]
      = 'Follow the path downhill to the lemur habitat.';
    directionMatrix[names.indexOf('Hamadryas Baboon')][names.indexOf('Meerkat')]
      = 'After walking uphill, take the path on the left to the meerkat habitat.';
    directionMatrix[names.indexOf('Hamadryas Baboon')][names.indexOf('Koala')]
      = 'After walking uphill, take the path on the right to the koala habitat.';
    directionMatrix[names.indexOf('Harpy Eagle')][names.indexOf('Zebra')]
      = 'Follow the uphill path with the road on your left to the zebras.';
    directionMatrix[names.indexOf('Harpy Eagle')][names.indexOf('Map Locator 15')]
      = 'Follow the path with the road on your right to the red circular sign on a signpost, Map Locator 15.';
    directionMatrix[names.indexOf('Hummingbird')][names.indexOf('Axolotl')]
      = 'Walk into Wildlife Explorer\'s Basecamp and enter Cool Critters.';
    directionMatrix[names.indexOf('Hummingbird')][names.indexOf('Komodo Dragon')]
      = 'Walk to Komodo Kingdom.';
    directionMatrix[names.indexOf('Kangaroo Stop 1')][names.indexOf('Cheetah')]
      = 'Turn slightly right and walk forward to the cheetah habitat.';
    directionMatrix[names.indexOf('Kangaroo Stop 1')][names.indexOf('Giraffe')]
      = 'Turn slightly left and walk forward to the giraffe habitat.';
    directionMatrix[names.indexOf('Kangaroo Stop 1')][names.indexOf('Koala')]
      = 'Turn and walk towards the large building with a red roof.';
    directionMatrix[names.indexOf('Kangaroo Stop 3')][names.indexOf('Polar Bear')]
      = 'Walk towards the Skyfari and continue down the hill to  Polar Bear Plunge.';
    directionMatrix[names.indexOf('Kangaroo Stop 3')][names.indexOf('Map Locator 20')]
      = 'Walk away from the Skyfari and follow the pedestrian path on the right to the red circular sign on a signpost, Map Locator 20.';
    directionMatrix[names.indexOf('Koala')][names.indexOf('Hamadryas Baboon')]
      = 'Walk towards the Desert Garden and follow the pedestrian path to the Baboon habitat.';
    directionMatrix[names.indexOf('Koala')][names.indexOf('Kangaroo Stop 1')]
      = 'Walk towards Urban Jungle to the Kangaroo bus sign.';
    directionMatrix[names.indexOf('Koala')][names.indexOf('Map Locator 08')]
      = 'Walking past the male Koalas, turn left and then right to the red circular sign on a signpost, Map Locator 08.';
    directionMatrix[names.indexOf('Komodo Dragon')][names.indexOf('Galapagos Tortoise')]
      = 'Turn right out of Komodo Kingdom and walk to Reptile Mesa.';
    directionMatrix[names.indexOf('Komodo Dragon')][names.indexOf('Hummingbird')]
      = 'Walk to the Hummingbird Aviary.';
    directionMatrix[names.indexOf('Komodo Dragon')][names.indexOf('Map Locator 03')]
      = 'Exit Komodo Kingdom and walk to the opposite side of the Reptile House.';
    directionMatrix[names.indexOf('Lemur')][names.indexOf('Hamadryas Baboon')]
      = 'Follow the path up the hill to the Hamadryas baboon habitat.';
    directionMatrix[names.indexOf('Lemur')][names.indexOf('Penguin')]
      = 'Follow the path down the hill to the penguin habitat.';
    directionMatrix[names.indexOf('Leopard')][names.indexOf('Map Locator 15')]
      = 'Exit out the the \'Entrance\' of Asian Cats to the red circular sign on a signpost, Map Locator 15.';
    directionMatrix[names.indexOf('Leopard')][names.indexOf('Red Panda')]
      = 'Walk to the exit of Asian Cats and follow the pedestrian path to the Panda Habitat.';
    directionMatrix[names.indexOf('Lion')][names.indexOf('Elephant')]
      = 'Facing the Lions, turn right and follow the pedestrian path to the elephant habitat.';
    directionMatrix[names.indexOf('Lion')][names.indexOf('Map Locator 20')]
      = 'Facing the Lions, turn left and follow the pedestrian path to the red circular sign on a signpost, Map Locator 20.';
    directionMatrix[names.indexOf('Mandrill')][names.indexOf('Gorilla')]
      = 'From the upstairs path, face the Mandrills and turn left. Follow the path to the gorilla habitat.';
    directionMatrix[names.indexOf('Mandrill')][names.indexOf('Tiger')]
      = 'From the downstairs path, face the Mandrills and turn left. Follow the fork to the right and walk downhill on Tiger Trail to reach the tigers.';
    directionMatrix[names.indexOf('Mandrill')][names.indexOf('Orangutan')]
      = 'From the downstairs path, face the Mandrills and turn right. Follow the fork to the left and follow the path to the orangutans.';
    directionMatrix[names.indexOf('Mandrill')][names.indexOf('Safari Kitchen')]
      = 'From the upstairs path, face the Mandrills and turn right. Follow the path to Safari Kitchen.';
    directionMatrix[names.indexOf('Map Locator 03')][names.indexOf('Galapagos Tortoise')]
      = 'Pass by the Reptile House and enter Reptile Mesa.';
    directionMatrix[names.indexOf('Map Locator 03')][names.indexOf('Komodo Dragon')]
      = 'Walk to the opposite side of the Reptile House to enter Komodo Kingdom.';
    directionMatrix[names.indexOf('Map Locator 03')][names.indexOf('Exit')]
      = 'Walk away from the Reptile House and find the Exit sign with a macaw on top.';
    directionMatrix[names.indexOf('Map Locator 04')][names.indexOf('Safari Kitchen')]
      = 'Walk clockwise around the flamingo pond to Safari Kitchen.';
    directionMatrix[names.indexOf('Map Locator 04')][names.indexOf('Fern Canyon')]
      = 'Walk counterclockwise around the flamingo pond and down Treetops Way to Fern Canyon.';
    directionMatrix[names.indexOf('Map Locator 04')][names.indexOf('Entrance')]
      = 'Turn away from the flamingo pond and cross the street to the Entrance.';
    directionMatrix[names.indexOf('Map Locator 08')][names.indexOf('Andean Bear')]
      = 'Walk down the steep hill to the Andean Bears on the right.';
    directionMatrix[names.indexOf('Map Locator 08')][names.indexOf('Koala')]
      = 'Walk towards the large building with the red roof.';
    directionMatrix[names.indexOf('Map Locator 08')][names.indexOf('Tasmanian Devil')]
      = 'Walk to the left of the bus road past the map of Australia to the Tasmanian Devils.';
    directionMatrix[names.indexOf('Map Locator 11')][names.indexOf('Andean Bear')]
      = 'Walk uphill following the path and road to the Andean Bears on the left.';
    directionMatrix[names.indexOf('Map Locator 11')][names.indexOf('Fern Canyon')]
      = 'Cross the road and walk up the stairs and path to the top of Fern Canyon.';
    directionMatrix[names.indexOf('Map Locator 11')][names.indexOf('Map Locator 13')]
      = 'Walk down the hill following the pedestrian path or the road to the red circular sign on a signpost, Map Locator 13.';
    directionMatrix[names.indexOf('Map Locator 13')][names.indexOf('Map Locator 11')]
      = 'Walk up the hill following the road or Sun Bear Trail to the red circular sign on a signpost, Map Locator 11.';
    directionMatrix[names.indexOf('Map Locator 13')][names.indexOf('Penguin')]
      = 'Follow the pedestrian path to Africa Rocks and the penguin habitat.';
    directionMatrix[names.indexOf('Map Locator 13')][names.indexOf('Red Panda')]
      = 'Walk towards the Panda Conservation building to the Red Pandas.';
    directionMatrix[names.indexOf('Map Locator 15')][names.indexOf('Harpy Eagle')]
      = 'Walk past the sand hippopotamus statue and follow Eagle Trail to the harpy eagle.';
    directionMatrix[names.indexOf('Map Locator 15')][names.indexOf('Leopard')]
      = 'Enter Asian Cats to see the leopards.';
    directionMatrix[names.indexOf('Map Locator 15')][names.indexOf('Tiger')]
      = 'Turn across from the sand hippopotamus statue and enter Tiger Trail to reach the tiger habitat.';
    directionMatrix[names.indexOf('Map Locator 20')][names.indexOf('Lion')]
      = 'Facing away from the bridge, turn right and follow the path to the lions.';
    directionMatrix[names.indexOf('Map Locator 20')][names.indexOf('Bashur Bridge Elevator')]
      = 'Walk across the bridge to the elevators on the other side.';
    directionMatrix[names.indexOf('Map Locator 20')][names.indexOf('Kangaroo Stop 3')]
      = 'Facing away from the bridge, turn left and follow the path to the Kangaroo bus sign.';
    directionMatrix[names.indexOf('Meerkat')][names.indexOf('Hamadryas Baboon')]
      = 'With the bus road to your left, follow the pedestrian path to the baboon habitat.';
    directionMatrix[names.indexOf('Meerkat')][names.indexOf('California Condor')]
      = 'With the bus road to your right, follow the pedestrian path to the California Condors.';
    directionMatrix[names.indexOf('Orangutan')][names.indexOf('Fern Canyon')]
      = 'Facing the orangutans, turn right and follow the path to the left to the top of Fern Canyon.';
    directionMatrix[names.indexOf('Orangutan')][names.indexOf('Mandrill')]
      = 'Facing the orangutans, turn right and follow the path to the right to reach the mandrill habitat.';
    directionMatrix[names.indexOf('Orangutan')][names.indexOf('Gorilla')]
      = 'Facing the orangutans, turn left and follow the path to the gorilla habitat.';
    directionMatrix[names.indexOf('Penguin')][names.indexOf('Lemur')]
      = 'Turn right from the penguins and follow the path uphill to the lemur habitat.';
    directionMatrix[names.indexOf('Penguin')][names.indexOf('Map Locator 13')]
      = 'Turn left from the penguins and follow the path to the red circular sign on a signpost, Map Locator 13.';
    directionMatrix[names.indexOf('Polar Bear')][names.indexOf('Zebra')]
      = 'Walk down the hill to the zebra habitat.';
    directionMatrix[names.indexOf('Polar Bear')][names.indexOf('Kangaroo Stop 3')]
      = 'Walk up the hill to the Kangaroo bus stop.';
    directionMatrix[names.indexOf('Red Panda')][names.indexOf('Leopard')]
      = 'Enter the \'Exit\' of Asian Cats to reach the leopard habitats.';
    directionMatrix[names.indexOf('Red Panda')][names.indexOf('Bashur Bridge Elevator')]
      = 'Turn around and walk to the large elevator.';
    directionMatrix[names.indexOf('Red Panda')][names.indexOf('Map Locator 13')]
      = 'Exit Panda Passage and walk to the red circular sign on a signpost, Map Locator 08.';
    directionMatrix[names.indexOf('Safari Kitchen')][names.indexOf('Exit')]
      = 'Facing the food stall, turn left, cross the bus road, and walk towards the exit sign with a macaw on top.';
    directionMatrix[names.indexOf('Safari Kitchen')][names.indexOf('Map Locator 04')]
      = 'Walk counter clockwise around the flamingo pond to the red circular sign on a signpost, Map Locator 04.';
    directionMatrix[names.indexOf('Safari Kitchen')][names.indexOf('Mandrill')]
      = 'Facing away from the food stall, follow the path to the left down Monkey Trails to reach the mandrill habitat.';
    directionMatrix[names.indexOf('Tasmanian Devil')][names.indexOf('Entrance')]
      = 'Facing the Tasmanian Devils, turn right and follow the winding path to the entrance.';
    directionMatrix[names.indexOf('Tasmanian Devil')][names.indexOf('Map Locator 08')]
      = 'Facing the Tasmanian Devils, turn left and cross the bus road to the red circular sign on a signpost, Map Locator 08.';
    directionMatrix[names.indexOf('Tiger')][names.indexOf('Map Locator 15')]
      = 'Walk down the hill to the red circular sign on a signpost, Map Locator 15.';
    directionMatrix[names.indexOf('Tiger')][names.indexOf('Mandrill')]
      = 'Walk up the hill to the mandrill habitat.';
    directionMatrix[names.indexOf('Zebra')][names.indexOf('Polar Bear')]
      = 'Walk up the hill to polar bear plunge.';
    directionMatrix[names.indexOf('Zebra')][names.indexOf('Harpy Eagle')]
      = 'Walk down the hill to Eagle Trail and the harpy eagle.';

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
  int start = names.indexOf('Entrance');
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