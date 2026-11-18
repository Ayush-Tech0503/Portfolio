// import 'package:flutter/material.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:search_map_location/utils/google_search/place.dart';
// import 'package:search_map_location/widget/search_widget.dart';
//
// const kGoogleApiKey = 'AIzaSyCEau5V4Y5PeuwSop-AK_LlLnE1GRxOTx0'; // Replace with your Google API Key
//
// final customTheme = ThemeData(
//   primarySwatch: Colors.blue,
//   brightness: Brightness.dark,
//   colorScheme: ColorScheme.fromSwatch(
//     primarySwatch: Colors.blue,
//     brightness: Brightness.dark,
//     accentColor: Colors.redAccent,
//   ),
//   inputDecorationTheme: const InputDecorationTheme(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(4.00)),
//     ),
//     contentPadding: EdgeInsets.symmetric(
//       vertical: 12.50,
//       horizontal: 10.00,
//     ),
//   ),
// );
//
// class RoutesWidget extends StatelessWidget {
//   const RoutesWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My App',
//       theme: customTheme,
//       routes: {
//         '/': (_) => const MyApp(),
//       },
//     );
//   }
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   TextEditingController _searchController = TextEditingController();
//   Mode _mode = Mode.overlay;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // _buildDropdownMenu(),
//             // const SizedBox(height: 12),
//             CustomDropdown(
//               searchController: _searchController,
//               mode: _mode,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDropdownMenu() {
//     return DropdownButton<Mode>(
//       value: _mode,
//       items: const <DropdownMenuItem<Mode>>[
//         DropdownMenuItem<Mode>(
//           value: Mode.overlay,
//           child: Text('Overlay'),
//         ),
//         DropdownMenuItem<Mode>(
//           value: Mode.fullscreen,
//           child: Text('Fullscreen'),
//         ),
//       ],
//       onChanged: (m) {
//         if (m != null) {
//           setState(() => _mode = m);
//         }
//       },
//     );
//   }
// }
//
// class CustomDropdown extends StatefulWidget {
//   final TextEditingController searchController;
//   final Mode mode;
//
//   const CustomDropdown({
//     Key? key,
//     required this.searchController,
//     required this.mode,
//   }) : super(key: key);
//
//   @override
//   _CustomDropdownState createState() => _CustomDropdownState();
// }
//
// class _CustomDropdownState extends State<CustomDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         TextFormField(
//           controller: widget.searchController,
//           onTap: () {
//             _handleSearch();
//
//           },
//           decoration: const InputDecoration(
//             labelText: 'Search for a place',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         // Display your custom dropdown with suggestions here.
//         // You can use a ListView or a DropdownButton or any other widget
//         // to display the suggestions.
//       ],
//     );
//   }
//
//   Future<void> _handleSearch() async {
//     void onError(PlacesAutocompleteResponse response) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(response.errorMessage ?? 'Unknown error'),
//         ),
//       );
//     }
//
//     // show input autocomplete with selected mode
//     // then get the Prediction selected
//     final p = await PlacesAutocomplete.show(
//
//       context: context,
//       apiKey: kGoogleApiKey,
//       onError: onError,
//       mode: widget.mode,
//       language: 'in',
//       components: [Component(Component.country, 'in')],
//       resultTextStyle: Theme.of(context).textTheme.titleMedium,
//     );
//
//     await displayPrediction(p, ScaffoldMessenger.of(context));
//   }
// }
//
// Future<void> displayPrediction(
//     Prediction? p, ScaffoldMessengerState messengerState) async {
//   if (p == null) {
//     return;
//   }
//
//   // get detail (lat/lng)
//   final _places = GoogleMapsPlaces(
//     apiKey: kGoogleApiKey,
//     apiHeaders: await const GoogleApiHeaders().getHeaders(),
//   );
//
//   final detail = await _places.getDetailsByPlaceId(p.placeId!);
//   final geometry = detail.result.geometry!;
//   final lat = geometry.location.lat;
//   final lng = geometry.location.lng;
//
//   messengerState.showSnackBar(
//     SnackBar(
//       content: Text('${p.description} - $lat/$lng'),
//     ),
//   );
// }
//
// class MapData extends StatefulWidget {
//   const MapData({Key? key}) : super(key: key);
//
//   @override
//   State<MapData> createState() => _MapDataState();
// }
//
// class _MapDataState extends State<MapData> {
//   //String _address = "";
//   var _address;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location Autocomplete'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Selected Address:',
//                 style: TextStyle(fontSize: 18),
//               ),
//               // Text(
//               //   _address,
//               //   style: TextStyle(fontSize: 24),
//               // ),
//               SizedBox(height: 20),
//               SearchLocation(
//                 placeholder:"search",
//                 apiKey: "AIzaSyCEau5V4Y5PeuwSop-AK_LlLnE1GRxOTx0",
//                 country: "IN",
//                 onSelected: (Place place) {
//                   setState(() {
//                     _address = place.description;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
