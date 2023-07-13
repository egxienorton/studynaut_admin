import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:studynautz/core/typography/typo.dart';
import 'package:studynautz/core/wizzy/appBars/appBar.dart';

//TODO: In spare time, bring in comments and also nested comments!!

class _CustomPageScrollPhysics extends PageScrollPhysics {
  // Set a maximum scroll velocity
  final double maxVelocity = 50000.0;

  @override
  double get minFlingVelocity => 0.0;

  @override
  double get maxFlingVelocity => maxVelocity;
}

class TikReels extends StatefulWidget {
  const TikReels({super.key});

  @override
  State<TikReels> createState() => _TikReelsState();
}

class _TikReelsState extends State<TikReels> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          PageView.builder(
            physics: _CustomPageScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              // Create a widget for each page based on the index
              return AspectRatio(
                aspectRatio: 9 / 16,
                child: BetterPlayer.network(
                  // widget.videoPath,
                  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",

                  betterPlayerConfiguration: BetterPlayerConfiguration(
                      controlsConfiguration: BetterPlayerControlsConfiguration(
                          showControls: false),
                      looping: true,
                      aspectRatio: 9 / 16,
                      fit: BoxFit.cover),
                ),
              );
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: SafeArea(
                      // padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Related | For you',
                        style: AppTypography.header3(context),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TikAction(),
                    ],
                  ),
                  Row(
                    children: [
                      TkFooter(
                          title: 'Saraalikhan',
                          subtitle: 'Eiffel tower #beautiful',
                          description: 'Have you been here before'),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TKWidget extends StatelessWidget {
  const TKWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://plus.unsplash.com/premium_photo-1671070290631-4f523748712e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=773&q=80'))),
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      // color: Colors.amber,
      child: Stack(
        children: [
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Container(
          //           child: Padding(
          //             padding: const EdgeInsets.only(top: 8.0),
          //             child: Text(
          //               'Related | For you',
          //               style: AppTypography.header3(context),
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //     Column(
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             TikAction(),
          //           ],
          //         ),
          //         Row(
          //           children: [
          //             TkFooter(
          //                 title: 'Saraalikhan',
          //                 subtitle: 'Eiffel tower #beautiful',
          //                 description: 'Have you been here before'),
          //           ],
          //         ),
          //       ],
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}

class TikAction extends StatelessWidget {
  const TikAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TKSnippetIcon(icon: IconlyBold.chat, info: '2041', onTap: () {}),
          TKSnippetIcon(icon: IconlyLight.heart, info: '423.5K', onTap: () {}),
          TKSnippetIcon(icon: IconlyBold.send, info: 'Share', onTap: () {}),
          TKSnippetIcon(
              icon: IconlyBold.volume_off, info: 'Mute', onTap: () {}),
        ],
      ),
    );
  }
}

class TKSnippetIcon extends StatelessWidget {
  final IconData icon;
  final String info;
  final Function() onTap;

  const TKSnippetIcon(
      {required this.icon, required this.info, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            info,
            style: AppTypography.subtitle(context),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class TkFooter extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;

  TkFooter(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTypography.header5(context),
            ),
            Text(
              subtitle,
              style: AppTypography.header5X(context),
            ),
            Text(
              description,
              style: AppTypography.header4(context),
            ),
          ]),
    );
  }
}
