import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:school_management_system/student/resources/RefrencesServices/RefrencesPdfServices.dart';

//import '../view/Adjuncts/Component/QuizBrain.dart';

class QuizzController extends GetxController {
  getQuizzes() async {
    quizes.value = await RefrencesPdfServices.getQuizzes();
  }

  var questions = [].obs;
  var currentIndex = 0.obs;
  var isEnd = false.obs;
  var quizes = [].obs;

  getQues() {
    return questions[currentIndex.value].ques.toString();
  }

  var scoreKeeper = <Widget>[].obs;
  checkAnswer(bool ans) {
    if (ans == questions[currentIndex.value].ans)
      return true;
    else
      return false;
  }

  updateTonewQuestion() {
    if (currentIndex.value == questions.length) {
      isEnd.value = true;
      update();
    } else {
      currentIndex.value++;
      update();
    }
  }
}
