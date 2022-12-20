import 'package:gn_accessor/constants/database_collection.dart';

enum VariantDoc {
  locked('locked');

  const VariantDoc(this._docId);
  final String _docId;

  static String getDocId(String collection, VariantDoc variant) {
    switch (collection) {
      case dBodyIndex:
        final list = [locked];
        if (list.contains(variant)) return variant._docId;
        throw FormatException("There's no $variant in $collection collection");
      default:
        throw FormatException(
            "Variant doc doesn't exist in $collection collection");
    }
  }
}
