import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:get/get.dart';
import 'package:studynautz/core/themes2/app_colors.dart';
import 'package:studynautz/core/themes2/custom_text_styles.dart';
import 'package:studynautz/core/themes2/ui_parameters.dart';
import 'package:studynautz/coursera/quizo/leaderboard/widgets/custom_app_bar.dart';

import '../controllers/quiz_controller.dart';
import '../enums/loading_status.dart';
import '../leaderboard/widgets/content_area.dart';
import '../leaderboard/widgets/screen_background_decoration.dart';
import '../quiz_screen_placeholder.dart';
import '../quiz_widgets/answer_card.dart';
import '../quiz_widgets/main_button.dart';
import '../utils/countdown_timer.dart';
import 'quiz_overview_screen.dart';

class QuizeScreen extends GetView<QuizController> {
  const QuizeScreen({Key? key}) : super(key: key);

  static const String routeName = '/quizescreen';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onExitOfQuiz,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Obx(
                () => CountdownTimer(
                  time: controller.time.value,
                  color: kOnSurfaceTextColor,
                ),
              ),
              decoration: const ShapeDecoration(
                shape: StadiumBorder(
                    side: BorderSide(color: kOnSurfaceTextColor, width: 2)),
              ),
            ),
            showActionIcon: true,
            titleWidget: Obx(() => Text(
                  'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
                  style: kAppBarTS,
                )),
          ),
          body: BackgroundDecoration(
            child: Obx(
              () => Column(
                children: [
                  if (controller.loadingStatus.value == LoadingStatus.loading)
                    Expanded(
                        child: ContentArea(child: QuizScreenPlaceHolder())),
                  if (controller.loadingStatus.value == LoadingStatus.completed)
                    Expanded(
                      child: ContentArea(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              // controller.currentQuestion.value!.hasDiagram ==
                              //         'yes'
                              //     ? Container(
                              //         width: double.infinity,
                              //         height: 200,
                              //         decoration: BoxDecoration(
                              //             image: DecorationImage(
                              //                 image: NetworkImage(
                              //                     'https://www.wikihow.com/images/thumb/6/61/Solve-Matrices-Step-3-Version-2.jpg/aid1430946-v4-728px-Solve-Matrices-Step-3-Version-2.jpg.webp'))),
                              //       )
                              //     : Text('No Diagrams for this question'),

                              Math.tex(
                                  '${controller.currentQuestion.value!.question}',
                                  textStyle: TextStyle(fontSize: 20),
                                  mathStyle: MathStyle.text),

                              // Text(
                              //   controller.currentQuestion.value!.question,
                              //   style: kQuizeTS,
                              // ),
                              // Text(
                              //   controller.currentQuestion.value!.question,
                              //   style: kQuizeTS,
                              // ),
                              SizedBox(
                                height: 10,
                              ),

                              GetBuilder<QuizController>(
                                  id: 'answers_list',
                                  builder: (context) {
                                    return ListView.separated(
                                      itemCount: controller.currentQuestion
                                          .value!.answers.length,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(top: 25),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          height: 10,
                                        );
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final answer = controller
                                            .currentQuestion
                                            .value!
                                            .answers[index];
                                        return AnswerCard(
                                          isSelected: answer.identifier ==
                                              controller.currentQuestion.value!
                                                  .selectedAnswer,
                                          onTap: () {
                                            controller.selectAnswer(
                                                answer.identifier);
                                          },
                                          answer:
                                              '${answer.identifier}. ${answer.answer}',
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
                          Visibility(
                            visible: controller.isFirstQuestion,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: SizedBox(
                                height: 55,
                                width: 55,
                                child: MainButton(
                                  onTap: () {
                                    controller.prevQuestion();
                                  },
                                  child: const Icon(Icons.arrow_back_ios_new),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Visibility(
                                visible: controller.loadingStatus.value ==
                                    LoadingStatus.completed,
                                child: MainButton(
                                  onTap: () {
                                    controller.islastQuestion
                                        ? Get.toNamed(
                                            QuizOverviewScreen.routeName)
                                        : controller.nextQuestion();
                                  },
                                  title: controller.islastQuestion
                                      ? 'Complete'
                                      : 'Next',
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
