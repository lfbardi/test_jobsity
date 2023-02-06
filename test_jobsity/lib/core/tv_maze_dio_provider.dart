import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tvMazeDio = Provider<Dio>(
  ((ref) => Dio(
        BaseOptions(
          baseUrl: 'https://api.tvmaze.com',
        ),
      )),
);
