import 'dart:collection';

import '../../data/models/body_index_firestore_data.dart';

/// Body index domain model.
class BodyIndexDomain {
  String? id;
  DateTime? date;
  String? gender;
  int? age;
  int? height;
  num? weight;
  int? bodyAge;
  num? bodyMassIndex;
  num? bodyFatPercent;
  num? bodyFatKilo;
  num? skeletalMusclePercent;
  num? skeletalMuscleKilo;
  int? visceralFat;
  int? antioxidantValue;
  int? basalMetabolicRate;
  int? navel;
  int? waistline;
  int? abdomen;
  int? hip;
  int? leftUpperArm;
  int? rightUpperArm;
  int? leftThigh;
  int? rightThigh;
  int? leftCalf;
  int? rightCalf;
  DateTime? createdAt;

  BodyIndexDomain({
    this.id,
    this.date,
    this.gender,
    this.age,
    this.height,
    this.weight,
    this.bodyAge,
    this.bodyMassIndex,
    this.bodyFatPercent,
    this.bodyFatKilo,
    this.skeletalMusclePercent,
    this.skeletalMuscleKilo,
    this.visceralFat,
    this.antioxidantValue,
    this.basalMetabolicRate,
    this.navel,
    this.waistline,
    this.abdomen,
    this.hip,
    this.leftUpperArm,
    this.rightUpperArm,
    this.leftThigh,
    this.rightThigh,
    this.leftCalf,
    this.rightCalf,
    this.createdAt,
  });

  /// Convert [BodyIndexFirestoreData] into [BodyIndexDomain] object.
  factory BodyIndexDomain.fromData(BodyIndexFirestoreData model) =>
      BodyIndexDomain(
        id: model.id,
        date: model.date,
        gender: model.gender,
        age: model.age,
        height: model.height,
        weight: model.weight,
        bodyAge: model.bodyAge,
        bodyMassIndex: model.bodyMassIndex,
        bodyFatPercent: model.bodyFatPercent,
        bodyFatKilo: model.bodyFatKilo,
        skeletalMusclePercent: model.skeletalMusclePercent,
        skeletalMuscleKilo: model.skeletalMuscleKilo,
        visceralFat: model.visceralFat,
        antioxidantValue: model.antioxidantValue,
        basalMetabolicRate: model.basalMetabolicRate,
        navel: model.navel,
        waistline: model.waistline,
        abdomen: model.abdomen,
        hip: model.hip,
        leftUpperArm: model.leftUpperArm,
        rightUpperArm: model.rightUpperArm,
        leftThigh: model.leftThigh,
        rightThigh: model.rightThigh,
        leftCalf: model.leftCalf,
        rightCalf: model.rightCalf,
        createdAt: model.createdAt,
      );

  LinkedHashMap<String, dynamic> getBasicProfileComponentsMap() {
    return LinkedHashMap.of(<String, dynamic>{
      'gender': gender,
      'age': age,
      'height': height,
    });
  }

  LinkedHashMap<String, dynamic> getBodyIndexComponentsMap() {
    return LinkedHashMap.of(<String, dynamic>{
      'weight': weight,
      'bodyAge': bodyAge,
      'bodyMassIndex': bodyMassIndex,
      'bodyFatPercent': bodyFatPercent,
      'bodyFatKilo': bodyFatKilo,
      'skeletalMusclePercent': skeletalMusclePercent,
      'skeletalMuscleKilo': skeletalMuscleKilo,
      'visceralFat': visceralFat,
      'antioxidantValue': antioxidantValue,
      'basalMetabolicRate': basalMetabolicRate,
    });
  }

  LinkedHashMap<String, dynamic> getCircumferenceComponentsMap() {
    return LinkedHashMap.of(<String, dynamic>{
      'navel': navel,
      'waistline': waistline,
      'abdomen': abdomen,
      'hip': hip,
      'leftUpperArm': leftUpperArm,
      'rightUpperArm': rightUpperArm,
      'leftThigh': leftThigh,
      'rightThigh': rightThigh,
      'leftCalf': leftCalf,
      'rightCalf': rightCalf,
    });
  }
}
