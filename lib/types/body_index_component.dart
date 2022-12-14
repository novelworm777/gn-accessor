/// Body index component types.
enum BodyIndexComponent {
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

  const BodyIndexComponent(this.pretty, this.notation);
  final String pretty;
  final String? notation;

  /// Get [BodyIndexComponent] by key.
  static BodyIndexComponent getType(String key) {
    switch (key) {
      case "gender":
        return BodyIndexComponent.gender;
      case "age":
        return BodyIndexComponent.age;
      case "height":
        return BodyIndexComponent.height;
      case "weight":
        return BodyIndexComponent.weight;
      case "body_age":
        return BodyIndexComponent.bodyAge;
      case "body_mass_index":
        return BodyIndexComponent.bodyMassIndex;
      case "body_fat_percent":
        return BodyIndexComponent.bodyFatPercent;
      case "body_fat_kilo":
        return BodyIndexComponent.bodyFatKilo;
      case "skeletal_muscle_percent":
        return BodyIndexComponent.skeletalMusclePercent;
      case "skeletal_muscle_kilo":
        return BodyIndexComponent.skeletalMuscleKilo;
      case "visceral_fat":
        return BodyIndexComponent.visceralFat;
      case "antioxidant_value":
        return BodyIndexComponent.antioxidantValue;
      case "basal_metabolic_rate":
        return BodyIndexComponent.basalMetabolicRate;
      case "navel":
        return BodyIndexComponent.navel;
      case "waistline":
        return BodyIndexComponent.waistline;
      case "abdomen":
        return BodyIndexComponent.abdomen;
      case "hip":
        return BodyIndexComponent.hip;
      case "left_upper_arm":
        return BodyIndexComponent.leftUpperArm;
      case "right_upper_arm":
        return BodyIndexComponent.rightUpperArm;
      case "left_thigh":
        return BodyIndexComponent.leftThigh;
      case "right_thigh":
        return BodyIndexComponent.rightThigh;
      case "left_calf":
        return BodyIndexComponent.leftCalf;
      case "right_calf":
        return BodyIndexComponent.rightCalf;
      default:
        return BodyIndexComponent.unknown;
    }
  }

  static bool isBasicProfile(BodyIndexComponent component) {
    List<BodyIndexComponent> basicProfileComponents = [
      BodyIndexComponent.gender,
      BodyIndexComponent.age,
      BodyIndexComponent.height,
    ];
    return basicProfileComponents.contains(component);
  }
}
