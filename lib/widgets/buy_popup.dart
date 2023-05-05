// import 'package:flutter/material.dart';

// class BuyPopup extends StatefulWidget {
//   const BuyPopup({super.key});

//   @override
//   State<BuyPopup> createState() => _BuyPopupState();
// }

// class _BuyPopupState extends State<BuyPopup> {
//   late TextEditingController _controller;
//   double _amount = 100;

//   @override
//   void initState() {
//     _controller = TextEditingController(text: '$_amount');
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       height: 150,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             'How much do you want to buy?',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: _controller,
//             onChanged: (value) {
//               setState(() {
//                 _amount = double.tryParse(value) ?? 0;
//               });
//             },
//             decoration: const InputDecoration(
//               hintText: 'Enter amount',
//               border: OutlineInputBorder(),
//             ),
//             keyboardType: TextInputType.number,
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               // add your buy logic here
//               Navigator.pop(context);
//             },
//             child: const Text('Buy'),
//           ),
//         ],
//       ),
//     );
//   }
// }
