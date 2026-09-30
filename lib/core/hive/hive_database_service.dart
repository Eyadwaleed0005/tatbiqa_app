import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:tatbiqa/core/hive/local_database_service.dart';

import 'dart:developer' as developer;

class HiveDatabaseService implements LocalDatabaseService {
  HiveDatabaseService({
    this.enableLogging = kDebugMode,
    this.logRequestData = true,
    this.logResponseData = true,
  });

  final bool enableLogging;
  final bool logRequestData;
  final bool logResponseData;

  Future<Box<T>> _getBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    }
    return await Hive.openBox<T>(boxName);
  }

  @override
  Future<T?> getById<T>({required String boxName, required dynamic key}) async {
    return _execute(
      operation: 'GET BY ID',
      boxName: boxName,
      requestData: {'key': key},
      action: () async {
        final box = await _getBox<T>(boxName);
        return box.get(key);
      },
    );
  }

  @override
  Future<List<T>> getAll<T>({required String boxName}) async {
    return _execute(
      operation: 'GET ALL',
      boxName: boxName,
      action: () async {
        final box = await _getBox<T>(boxName);
        return box.values.toList();
      },
    );
  }

  @override
  Future<void> putData<T>({
    required String boxName,
    required dynamic key,
    required T value,
  }) async {
    return _execute(
      operation: 'PUT DATA',
      boxName: boxName,
      requestData: {'key': key, 'value': value},
      action: () async {
        final box = await _getBox<T>(boxName);
        await box.put(key, value);
      },
    );
  }

  @override
  Future<void> addData<T>({required String boxName, required T value}) async {
    return _execute(
      operation: 'ADD DATA',
      boxName: boxName,
      requestData: {'value': value},
      action: () async {
        final box = await _getBox<T>(boxName);
        await box.add(value);
      },
    );
  }

 @override
  Future<void> deleteData<T>({
    required String boxName,
    required dynamic key,
  }) async {
    return _execute(
      operation: 'DELETE DATA',
      boxName: boxName,
      requestData: {'key': key},
      action: () async {
        final box = Hive.isBoxOpen(boxName)
            ? Hive.box<T>(boxName)
            : await Hive.openBox<T>(boxName);
        await box.delete(key);
      },
    );
  }
  @override
  Stream<BoxEvent> watchBox({required String boxName}) async* {
    final box = Hive.isBoxOpen(boxName)
        ? Hive.box(boxName)
        : await Hive.openBox(boxName);

    _logStream(operation: 'WATCH BOX', boxName: boxName);
    yield* box.watch();
  }

  Future<T> _execute<T>({
    required String operation,
    required String boxName,
    Object? requestData,
    required Future<T> Function() action,
  }) async {
    _logRequest(operation: operation, boxName: boxName, data: requestData);

    final stopwatch = Stopwatch()..start();

    try {
      final result = await action();
      stopwatch.stop();

      _logResponse(
        operation: operation,
        boxName: boxName,
        response: result,
        duration: stopwatch.elapsed,
      );

      return result;
    } catch (error, stackTrace) {
      stopwatch.stop();

      _logError(
        operation: operation,
        boxName: boxName,
        error: error,
        stackTrace: stackTrace,
        duration: stopwatch.elapsed,
      );

      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void _logRequest({
    required String operation,
    required String boxName,
    Object? data,
  }) {
    if (!enableLogging) return;

    final buffer = StringBuffer()
      ..writeln('┌──────────── HIVE REQUEST ────────────')
      ..writeln('│ Operation: $operation')
      ..writeln('│ Box: $boxName');

    if (logRequestData && data != null) {
      buffer
        ..writeln('│ Data:')
        ..writeln(_addLinePrefix(_prettyPrint(data)));
    }

    buffer.writeln('└──────────────────────────────────────');

    developer.log(buffer.toString(), name: 'HiveDatabaseService');
  }

  void _logResponse({
    required String operation,
    required String boxName,
    Object? response,
    Duration? duration,
  }) {
    if (!enableLogging) return;

    final buffer = StringBuffer()
      ..writeln('┌──────────── HIVE RESPONSE ───────────')
      ..writeln('│ Operation: $operation')
      ..writeln('│ Box: $boxName');

    if (duration != null) {
      buffer.writeln('│ Duration: ${duration.inMilliseconds} ms');
    }

    if (logResponseData && response != null) {
      buffer
        ..writeln('│ Result:')
        ..writeln(_addLinePrefix(_prettyPrint(response)));
    }

    buffer.writeln('└──────────────────────────────────────');

    developer.log(buffer.toString(), name: 'HiveDatabaseService');
  }

  void _logError({
    required String operation,
    required String boxName,
    required Object error,
    required StackTrace stackTrace,
    Duration? duration,
  }) {
    if (!enableLogging) return;

    final buffer = StringBuffer()
      ..writeln('┌──────────── HIVE ERROR ─────────────')
      ..writeln('│ Operation: $operation')
      ..writeln('│ Box: $boxName');

    if (duration != null) {
      buffer.writeln('│ Duration: ${duration.inMilliseconds} ms');
    }

    buffer
      ..writeln('│ Error: $error')
      ..writeln('└─────────────────────────────────────');

    developer.log(
      buffer.toString(),
      name: 'HiveDatabaseService',
      error: error,
      stackTrace: stackTrace,
    );
  }

  void _logStream({required String operation, required String boxName}) {
    if (!enableLogging) return;
    developer.log(
      '⚡ HIVE STREAM [Box: $boxName] -> Listen Started',
      name: 'HiveDatabaseService',
    );
  }

  String _prettyPrint(Object object) {
    return object.toString();
  }

  String _addLinePrefix(String text) {
    return text.split('\n').map((line) => '│   $line').join('\n');
  }
}
