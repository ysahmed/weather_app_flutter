class Suggestion {
  final String _title;
  final String _subTitle;

  String get title => _title;
  String get subTitle => _subTitle;

  Suggestion({
    required title,
    required subTitle,
  })  : _title = title,
        _subTitle = subTitle;
}
