import 'package:astromedia/modules/home/domain/enums/media_type.dart';
import 'package:equatable/equatable.dart';

class AstronomicalMediaModel extends Equatable {
  final String copyright;
  final String date;
  final String explanation;
  final String hdUrl;
  final MediaType mediaType;
  final String title;
  final String url;

  const AstronomicalMediaModel({
    required this.copyright,
    required this.date,
    required this.explanation,
    required this.hdUrl,
    required this.mediaType,
    required this.title,
    required this.url,
  });
  
  @override
  List<Object?> get props => [title, copyright];
}
