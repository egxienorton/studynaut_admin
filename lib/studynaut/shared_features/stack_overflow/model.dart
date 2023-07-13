class QuestionModeler {
  String questionTitle;
  String question;
  List<AnswerModeler>? answers;
  String views;
  int votes;
  List<String> tags;
  String time;
  //asked, modified

  QuestionModeler(
      {required this.question,
      required this.questionTitle,
      required this.answers,
      required this.views,
      required this.votes,
      required this.time,
      required this.tags});
}

class AnswerModeler {
  String answer;
  int upVotes;
  String answerProvider;

  AnswerModeler(
      {required this.answer,
      required this.upVotes,
      required this.answerProvider});
}
