import 'dart:async';
import 'dart:developer';

import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'question_answer.dart';

class ChatGPT extends StatelessWidget {
  const ChatGPT({super.key});

  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

// const apiKey = 'sCiHfoL76lXeN6w4xc4qT3BlbkFJlcdT5aw7KRLZazu7pA6A';
const apiKey = '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';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? answer;
  final chatGpt = ChatGpt(apiKey: apiKey);
  bool loading = false;
  final testPrompt =
      'Which Disney character famously leaves a glass slipper behind at a royal ball?';

  final List<QuestionAnswer> questionAnswers = [];

  late TextEditingController textEditingController;

  StreamSubscription<StreamCompletionResponse>? streamSubscription;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = const Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.black45,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: Icon(IconlyBold.arrow_left_2),
          backgroundColor: Colors.transparent,
          title: const Text(
            "Chat AI",
            style: TextStyle(fontFamily: 'Satoshis'),
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: questionAnswers.length,
                  itemBuilder: (context, index) {
                    final questionAnswer = questionAnswers[index];
                    final answer = questionAnswer.answer.toString().trim();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              color: Colors.amber,
                              child: Text(
                                '${questionAnswer.question}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Satoshis',
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (answer.isEmpty && loading)
                          const Center(child: CircularProgressIndicator())
                        else
                          Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16),
                            constraints:
                                BoxConstraints(maxWidth: width * 3 / 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: borderRadius.subtract(
                                  BorderRadius.only(bottomLeft: radius)),
                            ),
                            child: Text(
                              ' $answer',
                              style: const TextStyle(color: Colors.green),
                            ),
                          ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(color: Colors.black),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: textEditingController,
                        decoration: const InputDecoration(
                            hintText: 'Type in...',
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                                color: Colors.white, fontFamily: 'Aspira')),
                        onFieldSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ClipOval(
                      child: Material(
                        color: Colors.blue, // Button color
                        child: InkWell(
                          onTap: _sendMessage,
                          child: const SizedBox(
                            width: 48,
                            height: 48,
                            child: Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sendMessage() async {
    final question = textEditingController.text;
    setState(() {
      textEditingController.clear();
      loading = true;
      questionAnswers.add(
        QuestionAnswer(
          question: question,
          answer: StringBuffer(),
        ),
      );
    });
    final testRequest = CompletionRequest(
      stream: true,
      maxTokens: 4000,
      messages: [Message(role: Role.user.name, content: question)],
    );
    await _streamResponse(testRequest);
    setState(() => loading = false);
  }

  _streamResponse(CompletionRequest request) async {
    streamSubscription?.cancel();
    try {
      final stream = await chatGpt.createChatCompletionStream(request);
      streamSubscription = stream?.listen(
        (event) => setState(
          () {
            if (event.streamMessageEnd) {
              streamSubscription?.cancel();
            } else {
              return questionAnswers.last.answer.write(
                event.choices?.first.delta?.content,
              );
            }
          },
        ),
      );
    } catch (error) {
      setState(() {
        loading = false;
        questionAnswers.last.answer.write("Error");
      });
      log("Error occurred: $error");
    }
  }
}
