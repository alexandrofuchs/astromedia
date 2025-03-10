
import 'package:astromedia/core/common/exceptions/app_exception.dart';
import 'package:astromedia/core/logs/app_logger.dart';
import 'package:equatable/equatable.dart';

part '../success_result.dart';
part '../fail_result.dart';

abstract class IResponseResult<DataType extends Object> extends Equatable {
  void resolve({
    required void Function(AppException error) onFail,
    required void Function(DataType data) onSuccess,
  }) {
    try {
      if (this is Success) {
        AppLogger.log(
            codeId: 'Success',
            method: 'resolve',
            namespace: runtimeType,
            serviceName: 'IResponseResult',
            details: (this as Success<DataType>).data);
        return onSuccess((this as Success<DataType>).data);
      }

      if (this is Fail) {
        return onFail((this as Fail).error);
      }
    } catch (e) {
      AppException(id: e, method: resolve, namespace: this);
    }
  }
}
