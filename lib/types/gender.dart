/// Gender types.
enum Gender {
  male("Male"),
  female("Female");

  const Gender(this.pretty);
  final String pretty;

  static Gender fromString(String str) {
    return Gender.values
        .firstWhere((element) => element.toString() == '$Gender.$str');
  }
}
