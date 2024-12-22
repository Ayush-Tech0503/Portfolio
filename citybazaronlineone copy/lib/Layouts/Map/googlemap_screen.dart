// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapScreen extends StatefulWidget {
//   double shopLatitude;
//   double shopLongitude;
//     MapScreen({super.key, required this.shopLatitude, required this.shopLongitude});
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   // LatLng initialLocation = const LatLng(37.7749, -122.4194);
//   // BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
//
//   @override
//   void initState() {
//     // addCustomIcon();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return
//       ClipRRect(
//         borderRadius: BorderRadius.circular(10.0),
//       child: GoogleMap(
//           initialCameraPosition: CameraPosition(
//              target: LatLng(widget.shopLatitude, widget.shopLongitude),
//             // target:  LatLng(37.7749, -122.4194),
//               tilt: 59.440717697143555,
//               zoom: 13.0,
//           ),
//           markers: {
//             Marker(
//               markerId:  const MarkerId("marker1"),
//               position: LatLng(widget.shopLatitude, widget.shopLongitude),
//               // position:  const LatLng(37.415768808487435, -122.08440050482749),
//               draggable: true,
//               onDragEnd: (value) {},
//               icon: BitmapDescriptor.defaultMarker,
//             ),
//           },
//       ),
//     );
//   }
// }










