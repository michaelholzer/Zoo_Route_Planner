# zoo_route_planner

Zoo Route Planner was created by Michael Holzer for CS 4750 - Mobile Application Development class
from California Polytechnic University, Pomona. This application was created using Flutter and Dart 
in Android Studio IDE. The libraries flutter_map and latlng2, included in the repository, were 
utilized to make this application functional. This application was created to help people better 
navigate around the San Diego Zoo.

Disclaimer: This program is not sponsored by the San Diego Zoo. There is no guarantee every animal,
direction, and location will be correct if and when the San Diego Zoo is visited. 

## Getting Started

This project was written and tested in Android Studio using an emulated Pixel 3a API. Flutter and 
dart were used to create and run this program. The main file is located in the lib folder and is 
titled main.dart. 

This program is standalone. As long as flutter is supported, any IDE should be capable of running
this program starting from main.dart.

### Notable Files Created and Libraries Used

- main.dart: This file contains the main initialization of the application and the home page where the user selects animals to visit. 
- route_map.dart: This file contains the page with a map that will load a route based on animals selected from main.
- route_text.dart: This file contains the page with written directions based on animals selected that will guide the user through the zoo.
- location_changer.dart: This file contains the page allowing users to change the starting location of the route.
- route_logic.dart: This file contains the algorithm and data necessary for the app to function.
- pubspec.yaml: This file has been edited to import flutter_map and latlng2
- [flutter_map](https://docs.fleaflet.dev/): This library is a versatile mapping package for Flutter.
- [latlng2](https://pub.dev/packages/latlong2/install): This library is essential to the implementation of flutter_map and provides a latitude and longitude coordinate system.
