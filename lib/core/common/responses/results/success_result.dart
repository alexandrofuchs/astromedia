part of 'i_response/i_response_result.dart';

class Success<DataType extends Object> extends IResponseResult<DataType>{
  final DataType data;

  Success(this.data);
  
  @override
  List<Object?> get props => [data];
}