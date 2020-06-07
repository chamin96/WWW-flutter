import 'package:hive/hive.dart';
import 'package:what_when_where/constants.dart';
import 'package:what_when_where/data/hive/constants.dart';
import 'package:what_when_where/data/models/question_sections/question_section.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'section_audio.freezed.dart';
part 'section_audio.g.dart';

@freezed
abstract class AudioSection with _$AudioSection implements QuestionSection {
  @HiveType(typeId: hiveAudioSectionTypeId)
  const factory AudioSection({
    @HiveField(hiveAudioSectionValueFieldId) @required String value,
  }) = _AudioSection;

  factory AudioSection.fromString({@required String string}) {
    final value =
        string.trim().replaceAll(RegExp(r'([\(\)\s]|aud:)'), '').trim();
    return AudioSection(
        value: (Uri.tryParse(value).isAbsolute)
            ? value
            : '${Constants.databaseUrl}/sounds/db/$value');
  }

  static TypeAdapter<AudioSection> createHiveAdapter() =>
      _$_AudioSectionAdapter();
}
