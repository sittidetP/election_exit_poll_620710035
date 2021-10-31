class CandidateItem{
  final int number;
  final String title;
  final String fullName;

  CandidateItem({
   required this.number,
   required this.title,
   required this.fullName
});

  factory CandidateItem.fromJson(Map<String, dynamic> json) {
    return CandidateItem(
      number: json['number'],
      title: json['title'],
      fullName: json['fullName'],
    );
  }
}