import 'dart:convert';

import 'package:projet0_strat/Models/matches_model.dart';

class MyDuelCodec extends Codec<Object?, Object?> {
  /// Create a codec.
  const MyDuelCodec();

  @override
  Converter<Object?, Object?> get decoder => const _MyDuelDecoder();

  @override
  Converter<Object?, Object?> get encoder => const _MyDuelEncoder();
}

class _MyDuelDecoder extends Converter<Object?, Object?> {
  const _MyDuelDecoder();

  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }
    final Map<String, dynamic> inputAsMap = input as Map<String, dynamic>;
    return Duel.fromJSON(inputAsMap);
  }
}

class _MyDuelEncoder extends Converter<Object?, Object?> {
  const _MyDuelEncoder();

  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }
    if (input is Duel) {
      return input.toJSON();
    }
    throw FormatException('Cannot encode type ${input.runtimeType}');
  }
}
