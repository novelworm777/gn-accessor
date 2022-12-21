import '../../types/body_index_component.dart';

class Component {
  BodyIndexComponent? type;
  dynamic value;
  bool isLocked;

  Component({
    this.type,
    this.value,
    this.isLocked = false,
  });
}
