class CandidateResultItem{
  final int number;
  final String title;
  final String fullName;
  final int score;

  CandidateResultItem({
    required this.number,
    required this.title,
    required this.fullName,
    required this.score
  });

  factory CandidateResultItem.fromJson(Map<String, dynamic> json) {
    return CandidateResultItem(
      number: json['number'],
      title: json['title'],
      fullName: json['fullName'],
      score: json['score']
    );
  }
}