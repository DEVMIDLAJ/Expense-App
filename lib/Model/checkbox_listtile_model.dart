class CheckboxListTileModel {
  final String title;
  final String subTitle;
  bool isSelected;

  CheckboxListTileModel({
    required this.title,
    required this.subTitle,
    this.isSelected = false,
  });
}
