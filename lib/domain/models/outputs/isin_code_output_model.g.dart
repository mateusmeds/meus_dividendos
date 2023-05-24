// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isin_code_output_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IsinCodeOutputModel _$IsinCodeOutputModelFromJson(Map<String, dynamic> json) =>
    IsinCodeOutputModel(
      isinCodes: (json['otherCodes'] as List<dynamic>?)
          ?.map((e) => IsinCodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IsinCodeOutputModelToJson(
        IsinCodeOutputModel instance) =>
    <String, dynamic>{
      'otherCodes': instance.isinCodes,
    };
