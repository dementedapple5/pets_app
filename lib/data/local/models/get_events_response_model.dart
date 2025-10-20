import 'package:pets_app/data/local/models/event_model.dart';

class GetEventsResponseModel {
  final List<EventModel> events;
  final String errorMessage;

  const GetEventsResponseModel({
    required this.events,
    required this.errorMessage,
  });

  factory GetEventsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetEventsResponseModel(
        events: json['events']
            .map((event) => EventModel.fromJson(event))
            .toList(),
        errorMessage: json['errorMessage'],
      );
}
