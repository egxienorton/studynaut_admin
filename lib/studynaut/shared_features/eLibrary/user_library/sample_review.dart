import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class Review1 extends StatefulWidget {
//   const Review1({Key? key}) : super(key: key);

//   @override
//   _Review1State createState() => _Review1State();
// }

// class _Review1State extends State<Review1> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.9,
//                             height: 320,
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFDBE2E7),
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: Stack(
//                               children: [
//                                 Align(
//                                   alignment: const AlignmentDirectional(0, 0),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(16),
//                                     child: Image.network(
//                                       'https://m.media-amazon.com/images/I/51ITxxhus3L._SY346_.jpg',
//                                       width: double.infinity,
//                                       height: double.infinity,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsetsDirectional.fromSTEB(
//                                       16, 16, 16, 16),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Card(
//                                             clipBehavior:
//                                                 Clip.antiAliasWithSaveLayer,
//                                             color: const Color(0x3A000000),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                             ),
//                                             child: FlutterFlowIconButton(
//                                               borderColor: Colors.transparent,
//                                               borderRadius: 30,
//                                               buttonSize: 46,
//                                               icon: const Icon(
//                                                 Icons.arrow_back_rounded,
//                                                 color: Colors.white,
//                                                 size: 24,
//                                               ),
//                                               onPressed: () {
//                                                 print('IconButton pressed ...');
//                                               },
//                                             ),
//                                           ),
//                                           Card(
//                                             clipBehavior:
//                                                 Clip.antiAliasWithSaveLayer,
//                                             color: const Color(0x3A000000),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                             ),
//                                             child: FlutterFlowIconButton(
//                                               borderColor: Colors.transparent,
//                                               borderRadius: 30,
//                                               buttonSize: 46,
//                                               icon: const Icon(
//                                                 Icons.favorite_border,
//                                                 color: Colors.white,
//                                                 size: 24,
//                                               ),
//                                               onPressed: () {
//                                                 print('IconButton pressed ...');
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsetsDirectional.fromSTEB(24, 20, 24, 0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Text(
//                             'Vacation Home',
//                             style: FlutterFlowTheme.of(context).title1.override(
//                                   fontFamily: 'Lexend Deca',
//                                   color: const Color(0xFF090F13),
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Text(
//                             '123 Disney Way, Willingmington, WV 24921',
//                             style:
//                                 FlutterFlowTheme.of(context).bodyText2.override(
//                                       fontFamily: 'Lexend Deca',
//                                       color: const Color(0xFF95A1AC),
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.normal,
//                                     ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           RatingBarIndicator(
//                             itemBuilder: (context, index) => const Icon(
//                               Icons.star_rounded,
//                               color: Color(0xFFFFA130),
//                             ),
//                             direction: Axis.horizontal,
//                             rating: 5,
//                             unratedColor: const Color(0xFF95A1AC),
//                             itemCount: 5,
//                             itemSize: 24,
//                           ),
//                           Padding(
//                             padding: const EdgeInsetsDirectional.fromSTEB(
//                                 12, 0, 0, 0),
//                             child: Text(
//                               '4/5 Reviews',
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyText2
//                                   .override(
//                                     fontFamily: 'Lexend Deca',
//                                     color: const Color(0xFF95A1AC),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Text(
//                             'DESCRIPTION',
//                             style:
//                                 FlutterFlowTheme.of(context).bodyText1.override(
//                                       fontFamily: 'Lexend Deca',
//                                       color: const Color(0xFF090F13),
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.normal,
//                                     ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsetsDirectional.fromSTEB(
//                                   0, 0, 0, 24),
//                               child: Text(
//                                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi.',
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyText2
//                                     .override(
//                                       fontFamily: 'Lexend Deca',
//                                       color: const Color(0xFF95A1AC),
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.normal,
//                                     ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF090F13),
//                   boxShadow: [
//                     const BoxShadow(
//                       blurRadius: 4,
//                       color: Color(0x55000000),
//                       offset: Offset(0, 2),
//                     )
//                   ],
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Text(
//                                 '\$156',
//                                 style: FlutterFlowTheme.of(context)
//                                     .subtitle1
//                                     .override(
//                                       fontFamily: 'Lexend Deca',
//                                       color: Colors.white,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(
//                                     4, 0, 0, 0),
//                                 child: Text(
//                                   '+ taxes',
//                                   style: FlutterFlowTheme.of(context)
//                                       .bodyText2
//                                       .override(
//                                         fontFamily: 'Lexend Deca',
//                                         color: const Color(0xFF95A1AC),
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.normal,
//                                       ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsetsDirectional.fromSTEB(
//                                 0, 4, 0, 0),
//                             child: Text(
//                               'per night',
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyText2
//                                   .override(
//                                     fontFamily: 'Lexend Deca',
//                                     color: const Color(0xFF95A1AC),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       FFButtonWidget(
//                         onPressed: () {
//                           print('Button pressed ...');
//                         },
//                         text: 'Book Now',
//                         options: FFButtonOptions(
//                           width: 130,
//                           height: 50,
//                           color: const Color(0xFF4B39EF),
//                           textStyle:
//                               FlutterFlowTheme.of(context).subtitle2.override(
//                                     fontFamily: 'Lexend Deca',
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                           elevation: 3,
//                           borderSide: const BorderSide(
//                             color: Colors.transparent,
//                             width: 1,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
