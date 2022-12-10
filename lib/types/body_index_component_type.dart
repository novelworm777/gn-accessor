/// Body index component types.
enum BodyIndexComponentType {
  gender("Gender", null),
  age("Age", " Y/O"),
  height("Height", "cm"),
  weight("Weight", "kg"),
  bodyAge("Body Age", null),
  bodyMassIndex("BMI", null),
  bodyFatPercent("Body Fat (%)", "%"),
  bodyFatKilo("Body Fat (kg)", "kg"),
  skeletalMusclePercent("Skeletal Muscle (%)", "%"),
  skeletalMuscleKilo("Skeletal Muscle (kg)", "kg"),
  visceralFat("Visceral Fat", null),
  antioxidantValue("Antioxidant Value", null),
  basalMetabolicRate("BMR", "kcal/day"),
  navel("Navel", "cm"),
  waistline("Waistline", "cm"),
  abdomen("Abdomen", "cm"),
  hip("Hip", "cm"),
  leftUpperArm("Upper Left Arm", "cm"),
  rightUpperArm("Upper Right Arm", "cm"),
  leftThigh("Left Thigh", "cm"),
  rightThigh("Right Thigh", "cm"),
  leftCalf("Left Calf", "cm"),
  rightCalf("Right Calf", "cm"),
  unknown("???", null);

  const BodyIndexComponentType(this.name, this.notation);
  final String name;
  final String? notation;

  /// Get [BodyIndexComponentType] by key.
  static BodyIndexComponentType getType(String key) {
    switch (key) {
      case "gender":
        return BodyIndexComponentType.gender;
      case "age":
        return BodyIndexComponentType.age;
      case "height":
        return BodyIndexComponentType.height;
      case "weight":
        return BodyIndexComponentType.weight;
      case "body_age":
        return BodyIndexComponentType.bodyAge;
      case "body_mass_index":
        return BodyIndexComponentType.bodyMassIndex;
      case "body_fat_percent":
        return BodyIndexComponentType.bodyFatPercent;
      case "body_fat_kilo":
        return BodyIndexComponentType.bodyFatKilo;
      case "skeletal_muscle_percent":
        return BodyIndexComponentType.skeletalMusclePercent;
      case "skeletal_muscle_kilo":
        return BodyIndexComponentType.skeletalMuscleKilo;
      case "visceral_fat":
        return BodyIndexComponentType.visceralFat;
      case "antioxidant_value":
        return BodyIndexComponentType.antioxidantValue;
      case "basal_metabolic_rate":
        return BodyIndexComponentType.basalMetabolicRate;
      case "navel":
        return BodyIndexComponentType.navel;
      case "waistline":
        return BodyIndexComponentType.waistline;
      case "abdomen":
        return BodyIndexComponentType.abdomen;
      case "hip":
        return BodyIndexComponentType.hip;
      case "left_upper_arm":
        return BodyIndexComponentType.leftUpperArm;
      case "right_upper_arm":
        return BodyIndexComponentType.rightUpperArm;
      case "left_thigh":
        return BodyIndexComponentType.leftThigh;
      case "right_thigh":
        return BodyIndexComponentType.rightThigh;
      case "left_calf":
        return BodyIndexComponentType.leftCalf;
      case "right_calf":
        return BodyIndexComponentType.rightCalf;
      default:
        return BodyIndexComponentType.unknown;
    }
  }
}
