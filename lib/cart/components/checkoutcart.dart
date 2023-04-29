// import 'package:flutter/material.dart';
//
// import '../../model/oder.dart';
//
// class CheckOutCart extends StatelessWidget {
//   // const CheckOutCart({Key? key}) : super(key: key);
//   double sum;
//   List<Orders> orders = [];
//
//   CheckOutCart({required this.sum, required this.orders});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//
//         Expanded(
//           child: TextButton(
//             style: ButtonStyle(
//               shape: MaterialStatePropertyAll(RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(0.0),
//                   side: const BorderSide(color: Colors.green))),
//               backgroundColor: const MaterialStatePropertyAll(Colors.white),
//               side: const MaterialStatePropertyAll(
//                   BorderSide(color: Colors.green)),
//               iconSize: const MaterialStatePropertyAll(
//                 50,
//               ),
//             ),
//             onPressed: () {},
//             child: Text(
//               "Sum:${sum}",
//               style: const TextStyle(
//                 fontSize: 14.0,
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: TextButton(
//             style: ButtonStyle(
//               shape: MaterialStatePropertyAll(RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(0.0))),
//               side: const MaterialStatePropertyAll(
//                   BorderSide(color: Colors.green)),
//             ),
//
//             // onPressed: (
//             //
//             //   )
//             //
//             onPressed: () {
//               // orders.clear();
//               // delete();
//             },
//             child: Text("Check out".toUpperCase(),
//                 style: const TextStyle(fontSize: 14)),
//           ),
//         )
//       ],
//     );
//   }
// }
