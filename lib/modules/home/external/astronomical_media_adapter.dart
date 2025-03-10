part of 'astronomical_media_repository.dart';

extension AstronomicalMediaAdapter on AstronomicalMediaModel {
  static AstronomicalMediaModel fromMap(Map<String, dynamic> map) =>
      AstronomicalMediaModel(
        copyright: map['copyright'],
        date: (map['date'] as String).fromYMDDateString('-')!,
        explanation: map['explanation'],
        hdUrl: map['hdurl'],
        mediaType: MediaType.fromValue(map['media_type']),
        title: map['title'],
        url: map['url'],
      );
}
