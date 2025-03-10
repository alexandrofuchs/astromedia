part of 'astronomical_media_repository.dart';

extension AstronomicalMediaAdapter on AstronomicalMediaModel {
  static AstronomicalMediaModel fromMap(Map<String, dynamic> map) =>
      AstronomicalMediaModel(
        copyright: map['copyright'],
        date: map['date'],
        explanation: map['explanation'],
        hdUrl: map['hdUrl'],
        mediaType: map['mediaType'],
        title: map['title'],
        url: map['url'],
      );
}
