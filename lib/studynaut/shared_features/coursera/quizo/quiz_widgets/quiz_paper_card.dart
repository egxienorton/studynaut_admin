import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studynautz/core/themes2/app_icons_icons.dart';
import 'package:studynautz/core/themes2/custom_text_styles.dart';
import 'package:studynautz/core/themes2/ui_parameters.dart';

import '../controllers/quiz_controller.dart';
import '../controllers/quiz_papers_controller.dart';
import '../leaderboard/leaderboard_screen.dart';
import '../leaderboard/widgets/icon_with_text.dart';
import '../models/quiz_paper_model.dart';

class QuizPaperCard extends GetView<QuizPaperController> {
  const QuizPaperCard({Key? key, required this.model, required this.cardIndex})
      : super(key: key);

  final QuizPaperModel model;
  final int cardIndex;

  @override
  Widget build(BuildContext context) {
    final QuizMicroController quizzler = Get.put(QuizMicroController());
    final QuizPaperController controller = Get.find<QuizPaperController>();
    const double _padding = 10.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: Theme.of(context).cardColor,
      ),
      child: GestureDetector(
        // borderRadius: UIParameters.cardBorderRadius,
        onTap: () {
          // debugPrint('SAMSUNG');
          // controller.saveToStorageWithBatch();
          // // quizzler.quizPaperModel = model;
          // quizzler.saveToStorageWithBatch(model);
          // Get the individual quiz too and other handshakes
          //

          //the former download emulator
          // Get.defaultDialog(
          //     title: "Getting these questions for you one time",
          //     titlePadding: const EdgeInsets.all(12),
          //     contentPadding: const EdgeInsets.all(12),
          //     radius: 5.0,
          //     titleStyle:
          //         const TextStyle(fontFamily: 'Product Sans', fontSize: 16),
          //     barrierDismissible: false,
          //     content: Container(
          //       padding: const EdgeInsets.all(10),
          //       child: Column(
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               const Text(
          //                 'Paper Type :',
          //                 style: TextStyle(fontFamily: 'Product Sans'),
          //               ),
          //               Text(model.paperType.toString()),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               const Text(
          //                 'Number of questions :',
          //                 style: TextStyle(fontFamily: 'Product Sans'),
          //               ),
          //               Text(model.questionsCount.toString()),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               const Text(
          //                 'Time allowed :',
          //                 style: TextStyle(fontFamily: 'Product Sans'),
          //               ),
          //               Text(model.timeSeconds.toString()),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               const Text(
          //                 'Year :',
          //                 style: TextStyle(fontFamily: 'Product Sans'),
          //               ),
          //               Text(model.title.toString()),
          //             ],
          //           ),
          //           const SizedBox(
          //             height: 10,
          //           ),
          //           const LinearProgressIndicator(),
          //         ],
          //       ),
          //     ),
          //     actions: [
          //       TextButton(
          //           onPressed: () async {
          //             controller.saveOneWithBatch(cardIndex);

          //             final zPaper = controller.allPapers[cardIndex];
          //             print(zPaper);
          //             await quizzler.saveToStorageWithBatch(zPaper);
          //             // Get the individual quiz too and other handshakes
          //           },
          //           child: const Text(
          //             'Get',
          //             style: TextStyle(fontFamily: 'Product Sans'),
          //           )),
          //       TextButton(
          //           onPressed: () {
          //             Get.back();
          //           },
          //           child: Text('Cancel'))
          //     ]);

          controller.navigatoQuestions(paper: model);
          print(model.toJson());
        },
        child: Padding(
            padding: const EdgeInsets.all(_padding),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: UIParameters.cardBorderRadius,
                      child: ColoredBox(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          child: SizedBox(
                            width: 65,
                            height: 65,
                            child: model.imageUrl == null ||
                                    model.imageUrl!.isEmpty
                                ? null
                                : Image.network(model.imageUrl!),
                          )),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: cardTitleTs(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Text(model.description),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: EasySeparatedRow(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 15);
                            },
                            children: [
                              IconWithText(
                                  icon: Icon(Icons.help_outline_sharp,
                                      color: Colors.blue[700]),
                                  text: Text(
                                    '${model.questionsCount} quizzes',
                                    style: kDetailsTS.copyWith(
                                        color: Colors.blue[700]),
                                  )),
                              IconWithText(
                                  icon: const Icon(Icons.timer,
                                      color: Colors.blueGrey),
                                  text: Text(
                                    model.timeInMinits(),
                                    style: kDetailsTS.copyWith(
                                        color: Colors.blueGrey),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
                Positioned(
                    bottom: -_padding,
                    right: -_padding,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        // Get.find<NotificationService>().showQuizCompletedNotification(id: 1, title: 'Sampole', body: 'Sample', imageUrl: model.imageUrl, payload: json.encode(model.toJson())  );
                        Get.toNamed(LeaderBoardScreen.routeName,
                            arguments: model);
                      },
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        child: const Icon(AppIcons.trophyoutline),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(kCardBorderrRadius),
                                bottomRight:
                                    Radius.circular(kCardBorderrRadius)),
                            color: Theme.of(context).primaryColor),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}

class XQuizPaperCard extends GetView<LocalQuizPaperController> {
  const XQuizPaperCard({Key? key, required this.model}) : super(key: key);

  final QuizPaperModel model;

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: Theme.of(context).cardColor,
      ),
      child: InkWell(
        borderRadius: UIParameters.cardBorderRadius,
        onTap: () {
          controller.navigatoQuestions(paper: model);
          // Get.defaultDialog(
          //   title: "Fetching these questions for you one time",
          //   titleStyle: TextStyle(fontFamily: 'Product Sans'),
          //   barrierDismissible: false,
          //   content: LinearProgressIndicator(),
          // );
          // controller.saveToStorageWithBatch();
        },
        child: Padding(
            padding: const EdgeInsets.all(_padding),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: UIParameters.cardBorderRadius,
                      child: ColoredBox(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          child: SizedBox(
                            width: 65,
                            height: 65,
                            child: model.imageUrl == null ||
                                    model.imageUrl!.isEmpty
                                ? null
                                : Image.network(model.imageUrl!),
                          )),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: cardTitleTs(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Text(model.description),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: EasySeparatedRow(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 15);
                            },
                            children: [
                              IconWithText(
                                  icon: Icon(Icons.help_outline_sharp,
                                      color: Colors.blue[700]),
                                  text: Text(
                                    '${model.questionsCount} quizzes',
                                    style: kDetailsTS.copyWith(
                                        color: Colors.blue[700]),
                                  )),
                              IconWithText(
                                  icon: const Icon(Icons.timer,
                                      color: Colors.blueGrey),
                                  text: Text(
                                    model.timeInMinits(),
                                    style: kDetailsTS.copyWith(
                                        color: Colors.blueGrey),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
                Positioned(
                    bottom: -_padding,
                    right: -_padding,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        // Get.find<NotificationService>().showQuizCompletedNotification(id: 1, title: 'Sampole', body: 'Sample', imageUrl: model.imageUrl, payload: json.encode(model.toJson())  );
                        Get.toNamed(LeaderBoardScreen.routeName,
                            arguments: model);
                      },
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        child: const Icon(AppIcons.trophyoutline),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(kCardBorderrRadius),
                                bottomRight:
                                    Radius.circular(kCardBorderrRadius)),
                            color: Theme.of(context).primaryColor),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
