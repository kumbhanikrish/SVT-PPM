class HomeModel {
  final List<Broadcast> events;
  final List<Broadcast> broadcasts;

  HomeModel({required this.events, required this.broadcasts});

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    events: List<Broadcast>.from(
      json["events"].map((x) => Broadcast.fromJson(x)),
    ),
    broadcasts: List<Broadcast>.from(
      json["broadcasts"].map((x) => Broadcast.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "events": List<dynamic>.from(events.map((x) => x.toJson())),
    "broadcasts": List<dynamic>.from(broadcasts.map((x) => x.toJson())),
  };
}

class Broadcast {
  final int id;
  final String image;
  final String title;
  final String date;
  final String place;

  Broadcast({
    required this.id,
    required this.image,
    required this.title,
    required this.date,
    required this.place,
  });

  factory Broadcast.fromJson(Map<String, dynamic> json) => Broadcast(
    id: json["id"],
    image: json["image"],
    title: json["title"],
    date: json["date"],
    place: json["place"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "title": title,
    "date": date,
    "place": place,
  };
}
