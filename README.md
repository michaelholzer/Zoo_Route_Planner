# zoo_route_planner

Zoo Route Planner was created by Michael Holzer for CS 4750 - Mobile Application Development class
from California Polytechnic University, Pomona. This application was created using Flutter and 
Dart in Android Studio IDE. The libraries flutter_map and latlng2 were also utilized to help make 
this application fully functional. This application was created to help people better navigate 
around the San Diego Zoo.

## Getting Started

This program functions with 5 files: main.dart, route_map.dart, route_text.dart, 
location_changer.dart and route_logic.dart. The file pubspec.yaml also holds the importing for the
additional libraries utilized. 

After pulling, the program is run from main.dart. This file not only holds the home page, but also
the initialization of the application itself. On the home page, the user is able to select the
animals they would like to visit, and are able to see a list of what animals are selected. Tapping
on the names of the animals adds or removes them from the list. There is navigation on the bottom 
to move to the other pages.

The next main page is route_map.dart. This page contains a map that will load a route based on the 
animals selected from main. Destinations are ordered by numbers and other notable locations are 
marked for reference as well. The user can navigate back to the main page as well as to changing the
starting location and viewing directions in text mode.

The text mode page is from route_text.dart. This page holds written directions that will guide the
user throughout the zoo. This scrollable list is organized by notable location that is also marked
on the map. This page can navigate to the main page, map page, and a page to change the starting
location.

The location changing page, location_changer.dart, allows the user to change the starting location.
This means users can update the directions to be more accurate to where they are located so they can 
better be directed throughout the zoo.

The only file that is not a page is route_logic.dart. This file holds the algorithm that fuels the 
core functionality of this app. This file holds the data for each location: name, coordinates, 
adjacency, and text directions. Through this information, all other pages are able to be displayed 
and function in a way that is useful for the user and nearly seamless in execution.