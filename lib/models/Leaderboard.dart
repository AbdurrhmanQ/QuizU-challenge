class Leaderboard {
  String name;
  int score;

  Leaderboard(this.name, this.score);

  Leaderboard.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        score = json['score'];
}
