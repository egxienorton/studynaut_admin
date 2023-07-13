import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VLC extends StatefulWidget {
  final String videoPath;
  const VLC({Key? key, required this.videoPath}) : super(key: key);

  @override
  State<VLC> createState() => _VLCState();
}

class _VLCState extends State<VLC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //
      // ),
      body: SafeArea(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer.network(
                widget.videoPath,
                // "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",

                betterPlayerConfiguration: BetterPlayerConfiguration(
                  aspectRatio: 16 / 9,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        'How to ace physics',
                        style:
                            TextStyle(fontFamily: 'Product Sans', fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    children: const [],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 40,
                      color: Colors.amberAccent,
                      child: Column(
                        children: const [
                          Text("Description and Guides",
                              style: TextStyle(
                                  fontFamily: 'Product Sans', fontSize: 20))
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
