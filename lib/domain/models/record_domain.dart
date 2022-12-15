import 'package:gn_accessor/data/models/record_firestore_data.dart';

/// Body index record domain model.
class RecordDomain {
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

  RecordDomain({
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

  /// Convert [RecordFirestoreData] into [RecordDomain] object.
  factory RecordDomain.fromData(RecordFirestoreData model) => RecordDomain(
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
}
