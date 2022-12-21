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

  /// Get [BodyIndexComponent] from string.
  static BodyIndexComponent fromString(String str) {
    return BodyIndexComponent.values.firstWhere(
        (element) => element.toString() == '$BodyIndexComponent.$str');
  }

  /// Check whether the component is one of basic profile components.
  static bool isBasicProfile(BodyIndexComponent component) {
    List<BodyIndexComponent> basicProfileComponents = [
      BodyIndexComponent.gender,
      BodyIndexComponent.age,
      BodyIndexComponent.height,
    ];
    return basicProfileComponents.contains(component);
  }
}
