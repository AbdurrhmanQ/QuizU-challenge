class Question {
  String question, a, b, c, d, correct;

  Question(this.question, this.a, this.b, this.c, this.d, this.correct);

  Question.fromJson(Map<String, dynamic> json)
      : question = json['Question'],
        a = json['a'],
        b = json['b'],
        c = json['c'],
        d = json['d'],
        correct = json['correct'];
}
