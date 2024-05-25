import 'package:hive/hive.dart';

part 'catigories_dto.g.dart';

@HiveType(typeId: 1, adapterName: 'CategoriesAdapter')
class CategoriesDto {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? imageUrl;
  @HiveField(3)
  List<CategoriesDto>? subCategories;

  CategoriesDto({this.id, this.name, this.imageUrl, this.subCategories});

  CategoriesDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
    return data;
  }
}
