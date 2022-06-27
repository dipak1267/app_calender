import 'dart:convert';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    required this.date,
    required this.event,
  });

  String date;
  Event? event;

  EventModel copyWith({
    required String date,
    required Event event,
  }) =>
      EventModel(
        date: date ?? this.date,
        event: event ?? this.event,
      );

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        date: json["date"] == null ? null : json["date"] ?? "",
        event: json["event"] == null ? null : Event.fromJson(json["event"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "event": event == null ? null : event!.toJson(),
      };
}

class Event {
  Event({
    required this.tittle,
    required this.description,
  });

  String tittle;
  String description;

  Event copyWith({
    required String tittle,
    required String description,
  }) =>
      Event(
        tittle: tittle ?? this.tittle,
        description: description ?? this.description,
      );

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        tittle: json["tittle"] == null ? null : json["tittle"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "tittle": tittle == null ? null : tittle,
        "description": description == null ? null : description,
      };
}
