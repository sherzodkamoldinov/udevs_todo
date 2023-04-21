// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String imgPath;
  const UserModel({
    this.name = 'Unknown',
    this.imgPath = '',
  });

  UserModel copyWith({
    String? name,
    String? imgPath,
  }) =>
      UserModel(
        name: name ?? this.name,
        imgPath: imgPath ?? this.imgPath,
      );
}
