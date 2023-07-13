import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:studynaut_admin/core/typography/curtina.dart';
import 'package:studynaut_admin/core/typography/typo.dart';
import '../stack_overflow/ask_question_dialog.dart';
import '../stack_overflow/model.dart';

import '../stack_overflow/placeholder.dart';
import '../stack_overflow/tag_filter.dart';

import 'answer_screen.dart';

class SolvoHome extends StatelessWidget {
  SolvoHome({super.key});

  List<QuestionModeler> dummyQuestions = [
    QuestionModeler(
        questionTitle: 'A question for aeb students',
        question: 'What is the botannica name for coconut',
        answers: [
          AnswerModeler(
              answer: 'Cocos nucifera',
              upVotes: 3,
              answerProvider: 'Dr. Ekene'),
          AnswerModeler(
              answer: 'Cocos nucifa', upVotes: 1, answerProvider: 'John Doe'),
          AnswerModeler(
              answer: 'Cocos Abravae', upVotes: 0, answerProvider: 'Justina')
        ],
        votes: 34,
        views: '24',
        time: 'Today',
        tags: ['coconut', 'AEB111']),
    QuestionModeler(
        questionTitle: 'The dimension for acceleration',
        question:
            'A car starts a journey from rest and moves at a constant speed of 100m/s for 20minutes. What is his final velocity and average speed?',
        answers: [
          AnswerModeler(
              answer:
                  '12 m/s and 40mph \n Solution \n To find this \n First convert the minutes into seconds \n 20 x 60 = 1200 secs \n Now divide by 100 \n We get 12m/s',
              upVotes: 13,
              answerProvider: 'Kizito'),
          AnswerModeler(
              answer: '35m/s and 20mph', upVotes: 1, answerProvider: 'Angel'),
          AnswerModeler(
              answer: '35m/s and 21.2mph', upVotes: 0, answerProvider: 'Ken')
        ],
        votes: 3,
        views: '4',
        time: 'Yesterday',
        tags: ['motion', 'PHY111']),
    QuestionModeler(
        questionTitle: 'What is the antilog of 20',
        question: 'I have issues with logarithms in math',
        answers: [
          AnswerModeler(answer: '10', upVotes: 4, answerProvider: 'Einstein'),
          AnswerModeler(answer: '300', upVotes: 2, answerProvider: 'Tobi'),
          AnswerModeler(answer: '100', upVotes: 0, answerProvider: 'Jenner')
        ],
        votes: 12,
        views: '1',
        time: 'Today',
        tags: ['logarithm', 'Math', 'EMA323']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Icon(IconlyBold.arrow_left_2),
        centerTitle: true,
        title: Text(
          'Stack Overflow',
          style: AppTypography.header3(context),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor:
                          Theme.of(context).primaryColorDark.withOpacity(.9),
                      title: Text(
                        'Filter',
                        style: AppTypography.header1(context),
                      ),
                      content: Container(
                        height: MediaQuery.of(context).size.height * .5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'By',
                              style: AppTypography.header3(context),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Most Answered',
                                  style: AppTypography.subtitle(context),
                                ),
                                Checkbox(value: true, onChanged: (val) {})
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Most Views',
                                  style: AppTypography.subtitle(context),
                                ),
                                Checkbox(value: true, onChanged: (val) {})
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Most Newest',
                                  style: AppTypography.subtitle(context),
                                ),
                                Checkbox(value: true, onChanged: (val) {})
                              ],
                            ),
                            Divider(),
                            Text(
                              'By Tags',
                              style: AppTypography.header2(context),
                            ),
                            Expanded(child: InterestTag())
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Handle "Yes" button tap
                            Navigator.of(context).pop(true); // Return true
                          },
                          child: Text(
                            'Filter',
                            style: AppTypography.header5(context),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle "No" button tap
                            Navigator.of(context).pop(false); // Return false
                          },
                          child: Text(
                            'Cancel',
                            style: AppTypography.header5(context),
                          ),
                        ),
                      ],
                    );
                  },
                ).then((value) {
                  // Process the result here
                  if (value != null && value is bool) {
                    if (value) {
                      // User selected "Yes"
                      // AuthController authController =
                      //     Get.find<AuthController>();
                      // authController.signOut();
                    } else {
                      // User selected "No"
                      Get.back();
                    }
                  }
                });
              },
              icon: Icon(IconlyBold.filter))
        ],
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.builder(
                itemCount: dummyQuestions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => AnswerScreen(
                            question: dummyQuestions[index],
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(15),
                      decoration: roundContainer.copyWith(
                          color: Theme.of(context).primaryColorLight),
                      child: Row(
                        children: [
                          Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '${dummyQuestions[index].votes.toString()} votes',
                                    style: AppTypography.caption(context),
                                  ),
                                  Text(
                                    dummyQuestions[index]
                                            .answers!
                                            .length
                                            .toString() +
                                        ' answers',
                                    style: AppTypography.caption(context),
                                  ),
                                  Text(
                                    '${dummyQuestions[index].views} views',
                                    style: AppTypography.caption(context),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dummyQuestions[index].questionTitle,
                                    style: AppTypography.subtitle(context),
                                  ),
                                  Text(
                                    dummyQuestions[index].question,
                                    style: AppTypography.header6(context)
                                        .copyWith(color: Colors.redAccent),
                                  ),
                                  Row(
                                    children: [
                                      Wrap(
                                        spacing: 7.0,
                                        runSpacing: 3.0,
                                        children: dummyQuestions[index]
                                            .tags
                                            .map((interest) {
                                          return FilterChip(
                                            selectedColor:
                                                Theme.of(context).primaryColor,
                                            label: Text(
                                              interest,
                                              style: TextStyle(
                                                  fontFamily: 'Satoshis',
                                                  fontSize: 8),
                                            ),
                                            // selected: isInterestSelected(interest),
                                            // onSelected: (_) => toggleInterest(interest),
                                            onSelected: (_) {},
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Asked ${dummyQuestions[index].time}',
                                        style: AppTypography.caption(context),
                                      ),
                                      Text(
                                        'Alex',
                                        style: AppTypography.caption(context)
                                            .copyWith(color: Colors.blueAccent),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            // child: ListView.builder(
            //     itemCount: 5,
            //     itemBuilder: (context, index) {
            //       return StackOverflowPlaceHolder();
            //     }),
          )),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                AskQuestionDialog(),
                elevation: 1,
                isScrollControlled: true,
                // backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
                backgroundColor: Theme.of(context).canvasColor,
                enableDrag: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    // Customize the border radius here
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Theme.of(context).primaryColorDark),
              child: Text(
                'Ask a Question',
                textAlign: TextAlign.center,
                style: AppTypography.header3(context),
              ),
            ),
          )
        ],
      )),
    );
  }
}
