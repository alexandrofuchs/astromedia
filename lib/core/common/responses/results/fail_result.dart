part of 'i_response/i_response_result.dart';

class Fail<DataType extends Object> extends IResponseResult<DataType> {
  Fail(this.error);
  
  final AppException error;
  
  @override
  List<Object?> get props => [error];
}
