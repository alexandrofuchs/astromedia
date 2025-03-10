part of 'home_bloc.dart';

enum HomeBlocStatus { initial, loading, loaded, failed }

class HomeBlocState extends Equatable {
  final HomeBlocStatus status;

  final AppException? error;
  final AstronomicalMediaModel? data;

  const HomeBlocState(this.status, {this.error, this.data});

  @override
  List<Object?> get props => [status];
}

abstract class HomeBlocEvent extends Equatable {}

class GetMedia extends HomeBlocEvent {
  @override
  List<Object?> get props => [];
}
