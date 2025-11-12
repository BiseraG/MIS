class Exam {
  final String subjectName;
  final DateTime dateTime;
  final List<String> venues;

  const Exam({
    required this.subjectName,
    required this.dateTime,
    required this.venues,
  });

  bool get isPast => dateTime.isBefore(DateTime.now());

  String get timeLeft {
    final now = DateTime.now();
    final difference = dateTime.difference(now);
    
    if (difference.isNegative) {
      return "Испитот помина";
    }
    
    final days = difference.inDays;
    final hours = difference.inHours.remainder(24);
    
    return "$days days, $hours hours";
  }
}