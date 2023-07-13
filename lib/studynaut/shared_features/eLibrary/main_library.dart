// import 'package:flutter/material.dart';

// class MainLibrary extends StatefulWidget {
//   const MainLibrary({super.key});

//   @override
//   State<MainLibrary> createState() => _MainLibraryState();
// }

// class _MainLibraryState extends State<MainLibrary> {
//   List<String> genre = ['romance', 'Sci-fi', 'anime', 'war'];

//   final Map<String, List<Stringput tp>>
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: Container(
//           child: SingleChildScrollView(
//             child: Column(children: [
//               Row(
//                 children: [Text('Welcome to the book store')],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               //  [...genre].map((e) => Container(

//               //  ))
//             ]),
//           ),
//         ),
//       );

//   Widget _buildBookCard(String bookTitle) {
//     // rating
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(bookTitle),
//       ),
//     );
//   }

//   List<Widget> _buildBookRow(List<String> books) {
//     return books.map((book) => _buildBookCard(book)).toList();
//   }

//   List<Widget> _buildBookRows() {
//     return genre.map((genre) {
//       return Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(genre, style: TextStyle(fontSize: 24)),
//           ),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(children: _buildBookRow(book)),
//           )
//         ],
//       );
//     }).toList();
//   }
// }
