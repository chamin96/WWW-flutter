// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class _$_TournamentStatusAdapter extends TypeAdapter<_$_TournamentStatus> {
  @override
  final typeId = 2;

  @override
  _$_TournamentStatus read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_TournamentStatus(
      isNew: fields[0] as bool,
      isBookmarked: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$_TournamentStatus obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isNew)
      ..writeByte(1)
      ..write(obj.isBookmarked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$_TournamentStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
