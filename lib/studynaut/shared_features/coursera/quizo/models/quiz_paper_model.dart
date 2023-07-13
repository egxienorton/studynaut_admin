import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:localstore/localstore.dart';

class QuizPaperModel {
  final String id;
  final String title;
  String? courseName;
  String? chapterName;
  String? moduleUnit;
  String? difficultyLevel;
  String? imageUrl;
  Rxn<String?>? url;
  final String description;
  final int timeSeconds;
  List<Question>? questions;
  final String? paperType;
  final int questionsCount;

  QuizPaperModel({
    required this.id,
    required this.title,
    this.imageUrl,
    this.chapterName,
    this.courseName,
    this.difficultyLevel,
    this.moduleUnit,
    this.paperType,
    required this.description,
    required this.timeSeconds,
    required this.questions,
    required this.questionsCount,
  });

  String timeInMinits() => "${(timeSeconds / 60).ceil()} mins";

  factory QuizPaperModel.fromString(String jsonString) =>
      QuizPaperModel.fromJson(json.decode(jsonString));

  QuizPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['idea'],
        title = json['title'] as String,
        imageUrl = json['image_url'] as String?,
        paperType = json['paperType'] as String?,
        chapterName = json['chapterName'] as String?,
        courseName = json['courseName'] as String?,
        difficultyLevel = json['difficultyLevel'] as String?,
        moduleUnit = json['moduleUnit'] as String?,
        description = json['Description'] as String,
        timeSeconds = json['time_seconds'] as int,
        questionsCount = 0,

        /// will be update in PapersDataUploader
        questions = json['questions'] == null
            ? []
            : (json['questions'] as List)
                .map(
                    (dynamic e) => Question.fromJson(e as Map<String, dynamic>))
                .toList();

  QuizPaperModel.fromJuJu(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'] as String,
        imageUrl = json['image_url'] as String?,
        paperType = json['paperType'] as String?,
        description = json['Description'] as String,
        timeSeconds = json['time_seconds'] as int,
        questionsCount = 0,

        /// will be update in PapersDataUploader
        questions = json['questions'] == null
            ? []
            : (json['questions'] as List)
                .map(
                    (dynamic e) => Question.fromJson(e as Map<String, dynamic>))
                .toList();

// alright yo listen up,, the main bombshell behind this constructor is to be a getter for the years.. that is what it is designed to work.. V7 engine in progress
  QuizPaperModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        title = snapshot['title'],
        imageUrl = snapshot['image_url'],
        description = snapshot['Description'],
        paperType = snapshot['paperType'],
        timeSeconds = snapshot['time_seconds'],
        questionsCount = snapshot['questions_count'] as int,
        questions = [];

  // make the engine to abstract the answer as per question from the sqflite database

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image_url': imageUrl,
        'Description': description,
        'paperType': paperType,
        'time_seconds': timeSeconds,
        // 'questions':
        //     questions == null ? [] : questions!.map((e) => e.toJson()).toList()
      };
}

extension ExtCourseChapter on QuizPaperModel {
  Future saveQuiz(String courseName, String chapterName, String diffLevel,
      String moduleUnit) async {
    final _db = Localstore.instance;
    print(
        'adding questions to this ${courseName}/${chapterName}/moduleUnits/${moduleUnit}/quiz/${diffLevel}/datacenter');
    return _db
        .collection('courses')
        .doc(courseName)
        .collection(chapterName)
        .doc('module units')
        .collection(moduleUnit)
        .doc('quiz')
        .collection(diffLevel)
        .doc('questions')
        .set(toJson());
  }
}

class Question {
  final String id;
  final String question;
  List<Answer> answers;

  // final String? hasDiagram;
  // final String? hasSolution;
  final String? correctAnswer;
  String? selectedAnswer;

  Question({
    required this.id,
    required this.question,
    required this.answers,
    this.correctAnswer,
    // this.hasDiagram,
    // this.hasSolution,
  });

  Question.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        question = snapshot['question'],
        answers = [],
        // hasDiagram = snapshot['hasDiagram'],
        // hasSolution = snapshot['hasSolution'],
        correctAnswer = snapshot['correct_answer'];

  Question.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        question = json['question'] as String,
        // hasDiagram = json['hasDiagram'] as String,
        // hasSolution = json['hasSolution'] as String,
        answers =
            (json['answers'] as List).map((e) => Answer.fromJson(e)).toList(),
        correctAnswer = json['correct_answer'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'answers':
            answers, // this field was commented out b4 now with .toJson()
        // 'hasDiagram': hasDiagram,
        // 'hasSolution': hasSolution,

        'correct_answer': correctAnswer
      };
}

class Answer {
  final String? identifier;
  final String? answer;

  Answer({
    this.identifier,
    this.answer,
  });

  Answer.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'] as String?,
        answer = json['Answer'] as String?;

  Answer.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier = snapshot['identifier'] as String?,
        answer = snapshot['answer'] as String?;

  Map<String, dynamic> toJson() => {'identifier': identifier, 'Answer': answer};
}

// we have to get really smart here...
// get the answers !!!!!
// refine them into maps
