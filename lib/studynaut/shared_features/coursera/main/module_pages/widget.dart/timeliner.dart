import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:studynaut_admin/studynaut/shared_features/coursera/main/module_pages/widget.dart/vlc.dart';
import 'package:localstore/localstore.dart';
import 'package:timelines/timelines.dart';

import '../../../reg/data_cylinder_models.dart';
import 'pdf_screen.dart';
import 'xie_image_viewer.dart';

const kTileHeight = 200.0;

class MaterialItem {
  final String materialName;
  final String materialType;
  final String materialDescription;
  final String progress;

  MaterialItem(
      {required this.materialName,
      required this.materialDescription,
      required this.progress,
      required this.materialType});
}

// we may likely use GX later on but let's just use vanilla stateful widgets

class TimelineStatusPage extends StatefulWidget {
  final String courseCode;
  final String chapterName;
  final String moduleName;

  const TimelineStatusPage(
      {super.key,
      required this.courseCode,
      required this.chapterName,
      required this.moduleName});

  @override
  State<TimelineStatusPage> createState() => _TimelineStatusPageState();
}

class _TimelineStatusPageState extends State<TimelineStatusPage> {
  final _db = Localstore.instance;
  // final _items = <String, Stuff>{};
  bool isLoading = true;
  List<Stuff> materials = [];

  StreamSubscription<Map<String, dynamic>>? _subscription;

  getAllMaterials() {
    final data = _db
        .collection('courses')
        .doc(widget.courseCode)
        .collection('chapters')
        .doc(widget.chapterName)
        .collection('materials')
        .get()
        .then((value) {
      if (value != null) {
        value.forEach((key, value) {
          materials.add(Stuff.fromMap(value));
        });

        print(materials);
      }
    });

    isLoading = false;
    setState(() {});
  }

  // getAllMaterials() {
  //   _subscription = _db
  //       .collection('courses')
  //       .doc(widget.courseCode)
  //       .collection('chapters')
  //       .doc(widget.chapterName)
  //       .collection('materials')
  //       .stream
  //       .listen((event) {
  //     final item = Stuff.fromMap(event);

  //     event.map(
  //       (key, value) => Stuff.fromMap(value),
  //     );

  //     print(item);

  //     _items.putIfAbsent(item.materialTitle, () => item);
  //   });

  //   print(_items.toString());
  //   isLoading = false;
  //   setState(() {});
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllMaterials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _Timeline1(
                      materialForTheUnit: materials,
                    ),
              const SizedBox(width: 12.0),
              // _Timeline2(),
              // SizedBox(width: 12.0),
              // _Timeline3(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Timeline1 extends StatelessWidget {
  final List<Stuff> materialForTheUnit;

  const _Timeline1({required this.materialForTheUnit});
  // final List<MaterialItem> materialForTheUnit = [
  //   MaterialItem(
  //       materialName: 'Intro to statics',
  //       materialDescription: 'A beginner\'s introduction',
  //       progress: 'done',
  //       materialType: 'pdf'),
  //   MaterialItem(
  //       materialName: 'What rigid bodies really are',
  //       materialDescription: 'A beginner\'s introduction',
  //       progress: 'done',
  //       materialType: 'mp4'),
  //   MaterialItem(
  //       materialName: 'Particle Kinematics',
  //       materialDescription: 'A beginner\'s introduction',
  //       progress: 'in-progress',
  //       materialType: 'pdf'),
  //   MaterialItem(
  //       materialName: 'Free body diagrams',
  //       materialDescription: 'A beginner\'s introduction',
  //       progress: 'no-progress',
  //       materialType: 'pdf'),
  //   MaterialItem(
  //       materialName: 'Newtonian Mechanics',
  //       materialDescription: 'A beginner\'s introduction',
  //       progress: 'no-progress',
  //       materialType: 'pdf'),
  //   MaterialItem(
  //       materialName: '3D vectors',
  //       materialDescription: 'A beginner\'s introduction',
  //       progress: 'no-progress',
  //       materialType: 'pdf')
  // ];
  @override
  Widget build(BuildContext context) {
    // final data = _TimelineStatus.values;
    final data = materialForTheUnit;
    return Flexible(
      child: Timeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0,
          connectorTheme: const ConnectorThemeData(
            thickness: 3.0,
            color: Color(0xffd3d3d3),
          ),
          indicatorTheme: const IndicatorThemeData(
            size: 15.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        builder: TimelineTileBuilder.connected(
          contentsBuilder: (_, index) => _MaterialMeta(
            indexer: index,
            allUnitModulesList: [...materialForTheUnit],
            name: materialForTheUnit[index].materialTitle,
            description: materialForTheUnit[index].materialTitle,
            type: materialForTheUnit[index].materialType,
            // progress: materialForTheUnit[index].progress!,
            progress: 'in-progress',
          ),
          connectorBuilder: (_, index, __) {
            if (materialForTheUnit[index].progress == 'done') {
              return const SolidLineConnector(color: Color(0xff6ad192));
            } else {
              return const SolidLineConnector();
            }
          },
          indicatorBuilder: (_, index) {
            switch (data[index].progress) {
              case 'done':
                return const DotIndicator(
                  color: Color(0xff6ad192),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 10.0,
                  ),
                );
              // case _TimelineStatus.sync:
              //   return DotIndicator(
              //     color: Color(0xff193fcc),
              //     child: Icon(
              //       Icons.sync,
              //       size: 10.0,
              //       color: Colors.white,
              //     ),
              //   );
              case 'in-progress':
                return const OutlinedDotIndicator(
                  color: Color(0xffa7842a),
                  borderWidth: 2.0,
                  backgroundColor: Color(0xffebcb62),
                );
              case 'no-progress':
              default:
                return const OutlinedDotIndicator(
                  color: Color(0xffbabdc0),
                  backgroundColor: Color(0xffe6e7e9),
                );
            }
          },
          itemExtentBuilder: (_, __) => kTileHeight,
          itemCount: data.length,
        ),
      ),
    );
  }
}

class _MaterialMeta extends StatelessWidget {
  final int indexer;
  final String name;
  final String description;
  final String type;
  final String progress;
  final List<Stuff> allUnitModulesList;

  const _MaterialMeta(
      {required this.indexer,
      required this.name,
      required this.description,
      required this.type,
      required this.progress,
      required this.allUnitModulesList});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 20, 20, 10),
      child: GestureDetector(
        onTap: () {
          // trying to prevent users from going into a future module when they shouldn't

          if (indexer == 0) {
            if (type == 'pdf') {
              Get.to(() => PDFScreen(
                    path: allUnitModulesList[indexer].loca!,
                  ));
            } else if (type == 'mp4') {
              Get.to(() => VLC(
                    videoPath: allUnitModulesList[indexer].loca!,
                  ));
            } else if (type == 'jpg' || type == 'png') {
              Get.to(() => XieImageViewer(
                  imageFilePath: allUnitModulesList[indexer].loca!));
            }
          } else if (false) {
            // } else if (allUnitModulesList[indexer - 1].progress != 'done') {
            Get.snackbar('Ensure you complete the previous module',
                'before proceeding to the next one !');
          } else {
            if (type == 'pdf') {
              Get.to(() => PDFScreen(
                    path: allUnitModulesList[indexer].loca!,
                  ));
            } else if (type == 'mp4') {
              Get.to(() => VLC(
                    videoPath: allUnitModulesList[indexer].loca!,
                  ));
            } else if (type == 'jpg' || type == 'png') {
              Get.to(() => XieImageViewer(
                  imageFilePath: allUnitModulesList[indexer].loca!));
            }
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            child: Container(
              padding: const EdgeInsets.all(15),
              height: 900,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 175, 175, 207),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: ExactAssetImage(allUnitModulesList[indexer].toca!),
                ),
              ),
              child: Stack(children: [
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: type == 'pdf'
                            ? const Icon(IconlyBold.bookmark)
                            : type == 'mp4'
                                ? const Icon(IconlyBold.play)
                                : type == 'jpg'
                                    ? const Icon(IconlyBold.image)
                                    : type == 'png'
                                        ? const Icon(IconlyBold.image)
                                        : const Icon(IconlyBold.work))),
                Positioned(
                    bottom: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontFamily: 'Product Sans',
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          Text(description)
                        ],
                      ),
                    )),
              ]),
            ),
          ),
        ),
      ),
    );
    // _InnerTimeline(metadata: material[index].metadata),
  }
}

enum _TimelineStatus {
  done,
  inProgress,
  sync,
  todo,
}

extension on _TimelineStatus {
  bool get isInProgress => this == _TimelineStatus.inProgress;
}
