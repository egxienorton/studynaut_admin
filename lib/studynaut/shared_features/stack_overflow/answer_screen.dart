import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:studynaut_admin/core/typography/typo.dart';

import 'model.dart';

class AnswerScreen extends StatelessWidget {
  final QuestionModeler question;

  const AnswerScreen({required this.question, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          question.questionTitle,
          style: AppTypography.caption(context),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(IconlyBold.arrow_left_2),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                question.question,
                style: AppTypography.subtitle(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Answers',
                    style: AppTypography.header5(context)
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  Row(
                    children: [
                      Text(
                        'Highest score (default)',
                        style: AppTypography.caption(context),
                      ),
                      Icon(IconlyLight.arrow_down_3),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: question.answers!.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(IconlyLight.arrow_up_2)),
                                      Text(question.answers![index].upVotes
                                          .toString()),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(IconlyLight.arrow_down_2)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      question.answers![index].answer,
                                      style: AppTypography.header4(context)
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColorLight),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Answered on 28th May, 2020 at 08:00pm by ',
                                          style: AppTypography.caption(context),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          question
                                              .answers![index].answerProvider,
                                          style: AppTypography.subtitle(context)
                                              .copyWith(
                                                  color: Colors.blueAccent),
                                        ),
                                        Text(
                                          ' 264 ',
                                          style: AppTypography.header5(context),
                                        ),
                                        Icon(Icons.star_border)
                                      ],
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      );
                    }))),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Colors.green,
              ),
              child: Text('Answer this question',
                  textAlign: TextAlign.center,
                  style: AppTypography.header3(context)),
            ),
          ],
        ),
      ),
    );
  }
}
