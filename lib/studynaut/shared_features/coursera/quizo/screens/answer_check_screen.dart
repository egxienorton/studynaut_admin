// import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:studynautz/core/themes2/custom_text_styles.dart';
import 'package:studynautz/core/themes2/ui_parameters.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/quiz_controller.dart';
import '../leaderboard/widgets/content_area.dart';
import '../leaderboard/widgets/custom_app_bar.dart';
import '../leaderboard/widgets/screen_background_decoration.dart';
import '../quiz_widgets/answer_card.dart';
import '../quiz_widgets/main_button.dart';
import 'result_screen.dart';

class AnswersCheckScreen extends GetView<QuizController> {
  const AnswersCheckScreen({Key? key}) : super(key: key);

  static const String routeName = '/answercheck';
  final String _markdownData2 =
      r"""
                          <h1><h2>
                          <h2>\( \rm\\TeXViewInkWell\) 3 with ripple</h2>
                          <p>                                
                       When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
                       $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$</p>""";
  // final String _markdownData = r;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(() => Text(
              'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
              style: kAppBarTS,
            )),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(ResultScreen.routeName);
        },
      ),
      body: BackgroundDecoration(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: ContentArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          controller.currentQuestion.value!.question,
                          style: kQuizeTS,
                        ),
                        GetBuilder<QuizController>(
                            id: 'answers_review_list',
                            builder: (context) {
                              return ListView.separated(
                                itemCount: controller
                                    .currentQuestion.value!.answers.length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 25),
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  final answer = controller
                                      .currentQuestion.value!.answers[index];
                                  final selectedAnswer = controller
                                      .currentQuestion.value!.selectedAnswer;
                                  final correctAnswer = controller
                                      .currentQuestion.value!.correctAnswer;

                                  final String answerText =
                                      '${answer.identifier}. ${answer.answer}';

                                  if (correctAnswer == selectedAnswer &&
                                      answer.identifier == selectedAnswer) {
                                    return CorrectAnswerCard(
                                        answer: answerText);
                                  } else if (selectedAnswer == null) {
                                    // hmm look at this
                                    return NotAnswerCard(answer: answerText);
                                  } else if (correctAnswer != selectedAnswer &&
                                      answer.identifier == selectedAnswer) {
                                    return WrongAnswerCard(answer: answerText);
                                  } else if (correctAnswer ==
                                      answer.identifier) {
                                    return CorrectAnswerCard(
                                        answer: answerText);
                                  }

                                  return AnswerCard(
                                    isSelected: false,
                                    onTap: () {},
                                    answer: answerText,
                                  );
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIParameters.screenPadding,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: MainButton(
                          onTap: () {
                            controller.prevQuestion();
                          },
                          child: const Icon(IconlyBold.arrow_left_2),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: MainButton(
                          onTap: () {
                            ///
                            Get.bottomSheet(
                              FutureBuilder(
                                  future: rootBundle
                                      .loadString("assets/md5/ELA201.md"),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String> snapshot) {
                                    if (snapshot.hasData) {
                                      return Markdown(
                                        data: snapshot.data!,
                                        imageDirectory:
                                            '/data/user/0/com.formidable.academy/app_flutter',
                                      );
                                    }
                                    return Center(
                                      child:
                                          LoadingAnimationWidget.twistingDots(
                                        leftDotColor: const Color(0xFF1A1A3F),
                                        rightDotColor: const Color(0xFFEA3799),
                                        size: 200,
                                      ),
                                    );
                                  }),
                              // Text('Hello World'),
                              // Markdown(data: _markdownData),

                              // Padding(
                              //   padding: const EdgeInsets.all(12.0),
                              //   child: TeXView(
                              //       child: TeXViewColumn(children: [
                              //     TeXViewDocument(_markdownData),
                              //   ])),
                              // ),

                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: ListView(
                              //     children: [
                              //       Text(
                              //         'Solution',
                              //         textAlign: TextAlign.center,
                              //         style: TextStyle(
                              //             fontFamily: 'Product Sans',
                              //             fontSize: 20),
                              //       ),
                              //       SizedBox(
                              //         height: 10,
                              //       ),
                              //       Container(
                              //         padding: EdgeInsets.all(20),
                              //         height: 200,
                              //         width: double.infinity,
                              //         decoration: BoxDecoration(
                              //             image: DecorationImage(
                              //                 image: NetworkImage(
                              //                     'https://www.wikihow.com/images/thumb/0/01/Solve-Matrices-Step-26.jpg/aid1430946-v4-728px-Solve-Matrices-Step-26.jpg.webp'))),
                              //       ),
                              //       SizedBox(
                              //         height: 10,
                              //       ),
                              //       Container(
                              //         padding: EdgeInsets.all(20),
                              //         height: 200,
                              //         width: double.infinity,
                              //         decoration: BoxDecoration(
                              //             image: DecorationImage(
                              //                 image: NetworkImage(
                              //                     'https://www.wikihow.com/images/thumb/b/b6/Solve-Matrices-Step-27.jpg/aid1430946-v4-728px-Solve-Matrices-Step-27.jpg.webp'))),
                              //       ),
                              //       Container(
                              //         padding: EdgeInsets.all(20),
                              //         height: 200,
                              //         width: double.infinity,
                              //         decoration: BoxDecoration(
                              //             image: DecorationImage(
                              //                 image: NetworkImage(
                              //                     'https://www.wikihow.com/images/thumb/0/01/Solve-Matrices-Step-26.jpg/aid1430946-v4-728px-Solve-Matrices-Step-28.jpg.webp'))),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              elevation: 20.0,
                              enableDrag: true,
                              ignoreSafeArea: false,
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                              ),
                            );
                          },
                          title: 'Show Solution',
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: MainButton(
                          onTap: () {
                            controller.nextQuestion();

                            ///
                            ///
                          },
                          child: const Icon(IconlyBold.arrow_right_2),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
