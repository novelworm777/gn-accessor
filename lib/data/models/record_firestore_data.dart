import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gn_accessor/domain/models/record_domain.dart';

/// Body index record firestore data model.
class RecordFirestoreData {
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

  RecordFirestoreData({
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

  /// Convert [RecordDomain] into [RecordFirestoreData] object.
  factory RecordFirestoreData.fromDomain(RecordDomain model) =>
      RecordFirestoreData(
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

  /// Convert firestore snapshot into [RecordFirestoreData] object.
  factory RecordFirestoreData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final record = RecordFirestoreData.fromMap(data);
    record.id = snapshot.id;
    return record;
  }

  /// Convert [Map] into [RecordFirestoreData] object.
  factory RecordFirestoreData.fromMap(Map<String, dynamic>? map) =>
      RecordFirestoreData(
        id: map?['id'] as String?,
        date: map?['date'] as DateTime?,
        gender: map?['gender'] as String?,
        age: map?['age'] as int?,
        height: map?['height'] as int?,
        weight: map?['weight'] as num?,
        bodyAge: map?['bodyAge'] as int?,
        bodyMassIndex: map?['bodyMassIndex'] as num?,
        bodyFatPercent: map?['bodyFatPercent'] as num?,
        bodyFatKilo: map?['bodyFatKilo'] as num?,
        skeletalMusclePercent: map?['skeletalMusclePercent'] as num?,
        skeletalMuscleKilo: map?['skeletalMuscleKilo'] as num?,
        visceralFat: map?['visceralFat'] as int?,
        antioxidantValue: map?['antioxidantValue'] as int?,
        basalMetabolicRate: map?['basalMetabolicRate'] as int?,
        navel: map?['navel'] as int?,
        waistline: map?['waistline'] as int?,
        abdomen: map?['abdomen'] as int?,
        hip: map?['hip'] as int?,
        leftUpperArm: map?['leftUpperArm'] as int?,
        rightUpperArm: map?['rightUpperArm'] as int?,
        leftThigh: map?['leftThigh'] as int?,
        rightThigh: map?['rightThigh'] as int?,
        leftCalf: map?['leftCalf'] as int?,
        rightCalf: map?['rightCalf'] as int?,
        createdAt: map?['createdAt'] as DateTime?,
      );

  /// Convert [RecordFirestoreData] into firestore json.
  Map<String, dynamic> toFirestore() => {
        if (date != null) 'date': date,
        if (gender != null) 'gender': gender,
        if (age != null) 'age': age,
        if (height != null) 'height': height,
        if (weight != null) 'weight': weight,
        if (bodyAge != null) 'bodyAge': bodyAge,
        if (bodyMassIndex != null) 'bodyMassIndex': bodyMassIndex,
        if (bodyFatPercent != null) 'bodyFatPercent': bodyFatPercent,
        if (bodyFatKilo != null) 'bodyFatKilo': bodyFatKilo,
        if (skeletalMusclePercent != null)
          'skeletalMusclePercent': skeletalMusclePercent,
        if (skeletalMuscleKilo != null)
          'skeletalMuscleKilo': skeletalMuscleKilo,
        if (visceralFat != null) 'visceralFat': visceralFat,
        if (antioxidantValue != null) 'antioxidantValue': antioxidantValue,
        if (basalMetabolicRate != null)
          'basalMetabolicRate': basalMetabolicRate,
        if (navel != null) 'navel': navel,
        if (waistline != null) 'waistline': waistline,
        if (abdomen != null) 'abdomen': abdomen,
        if (hip != null) 'hip': hip,
        if (leftUpperArm != null) 'leftUpperArm': leftUpperArm,
        if (rightUpperArm != null) 'rightUpperArm': rightUpperArm,
        if (leftThigh != null) 'leftThigh': leftThigh,
        if (rightThigh != null) 'rightThigh': rightThigh,
        if (leftCalf != null) 'leftCalf': leftCalf,
        if (rightCalf != null) 'rightCalf': rightCalf,
        if (createdAt != null) 'createdAt': createdAt,
      };
}
