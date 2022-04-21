class NullEscape {
  final dynamic e;
  NullEscape(this.e);

  String withString([String defaultValue = '']) {
    return e?.toString() ?? defaultValue;
  }

  int _withInt() => e ?? 0;
  int get withInt => _withInt();

  double _withDouble() => e == null ? 0 : (e as num).toDouble();
  double get withDouble => _withDouble();

  bool _withBool() => e == true ? true : false;
  bool get withBool => _withBool();

  String _withListString(List<dynamic> e) => e.isEmpty ? '' : e[0];
  String get withListString => _withListString(e);

  DateTime _withDate(dynamic e) =>
      e == null ? DateTime.now() : DateTime.parse(e as String);
  DateTime get withDate => _withDate(e);
}
