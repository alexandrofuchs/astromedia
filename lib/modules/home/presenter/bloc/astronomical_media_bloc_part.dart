part of 'astronomical_media_bloc.dart';

enum AstronomicalMediaBlocStatus { initial, loading, loaded, failed }

class AstronomicalMediaBlocState extends Equatable {
  final AstronomicalMediaBlocStatus status;

  final AppException? error;
  final AstronomicalMediaModel? data;

  const AstronomicalMediaBlocState(this.status, {this.error, this.data});

  @override
  List<Object?> get props => [status];
}

abstract class AstronomicalMediaBlocEvent extends Equatable {}

class GetMediaEvent extends AstronomicalMediaBlocEvent {
  final DateTime date;

  GetMediaEvent(this.date);

  @override
  List<Object?> get props => [date];
}
