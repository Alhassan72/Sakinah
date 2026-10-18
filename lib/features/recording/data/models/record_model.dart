import 'package:sakinah/core/strings/db_constants.dart';
import 'package:sakinah/features/recording/domain/entities/record.dart';

class RecordModel extends Record {
  const RecordModel({
    super.id,
    required super.title,
    required super.date,
    required super.path,
    required super.duration,
    required super.isPlaying,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
    id: json[DbConstants.recordingId],
    title: json[DbConstants.recordingName] ?? '',
    path: json[DbConstants.recordingPath] ?? '',
    duration: json[DbConstants.recordingDuration] ?? 0,
    isPlaying: json[DbConstants.recordingPlay] ?? false,
    date: json[DbConstants.recordingDate] is DateTime
        ? json[DbConstants.recordingDate]
        : DateTime.tryParse(
                json[DbConstants.recordingDate]?.toString() ?? '',
              ) ??
              DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    DbConstants.recordingId: id,
    DbConstants.recordingName: title,
    DbConstants.recordingDate: date,
    DbConstants.recordingPath: path,
    DbConstants.recordingDuration: duration,
    DbConstants.recordingPlay: isPlaying,
  };
}
