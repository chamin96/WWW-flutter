import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:what_when_where/api/http/http_client.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => createDioInstance();

  @lazySingleton
  GlobalKey<NavigatorState> get key => GlobalKey<NavigatorState>();
}
