class Schedule {
  Schedule({
    this.time,
    this.days,
  });

  String? time;
  List<String>? days;

  factory Schedule.fromMap(Map<String, dynamic> json) => Schedule(
        time: json["time"] ?? 'Unavailable',
        days: List<String>.from(json["days"].map((x) => x) ?? ['Uniavailable']),
      );

  Map<String, dynamic> toMap() => {
        "time": time,
        "days": List<dynamic>.from(days!.map((x) => x)),
      };
}
