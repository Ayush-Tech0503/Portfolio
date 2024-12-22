// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
//
// Widget bottomNavScreen({
//   onTabChange, selectedIndex,gap,color,iconSize,tabBackgroundColor
// }) {
//   return Container(
//     decoration: BoxDecoration(
//       color: color,
//       boxShadow: [
//         BoxShadow(
//           blurRadius: 20,
//           color: Colors.black.withOpacity(0.02),
//         )
//       ],
//     ),
//     child: SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
//         child: GNav(
//           gap: gap,
//           activeColor: Colors.white,
//           iconSize: iconSize,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           duration: const Duration(milliseconds: 400),
//           tabBackgroundColor: tabBackgroundColor,
//          color: Colors.black,
//           tabs: const [
//             GButton(
//               icon: Icons.home,
//               text: 'Home',
//             ),
//             GButton(
//               icon: Icons.store,
//               text: 'Store',
//             ),
//             GButton(
//               icon: Icons.store,
//               text: 'Store',
//             ),
//             GButton(
//               icon: Icons.store,
//               text: 'Store',
//             ),
//                    GButton(
//                 icon: Icons.person,
//                      text: 'Account',
//               ),
//           ],
//           selectedIndex: selectedIndex,
//           onTabChange: onTabChange,
//         ),
//       ),
//     ),
//   );
// }

