sealed class ApiException implements Exception {
  const ApiException({required this.message});

  final String message;
}

class BadRequestException implements ApiException {
  @override
  String get message => '不正なリクエストです。';
}

class NotFoundException implements ApiException {
  @override
  String get message => '存在しないです。';
}

class UnprocessableEntityException implements ApiException {
  @override
  String get message => '処理に失敗しました。';
}

class UnexpectedException implements ApiException {
  @override
  String get message => '予期せぬエラーが発生しました。';
}
