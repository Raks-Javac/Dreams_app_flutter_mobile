class ListModel {
  String title;
  bool isActive;

  ListModel(this.isActive, this.title);

  ListModel copyWith({String? title, bool? isActive}) => ListModel(
        isActive ?? this.isActive,
        title ?? this.title,
      );
}
