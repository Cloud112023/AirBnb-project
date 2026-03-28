import 'user_object.dart';

class Posting {
  String? id;
  String? name;
  String? type;
  double? price;
  String? description;
  String? address;
  String? city;
  String? country;
  double? rating;

  Contact? host;

  List<String>? imagesName;
  List<String>? displayImages;
  List<String>? amenities;

  Map<String, int>? beds;
  Map<String, int>? bathroom;

  Posting({
    this.id = '',
    this.name = "",
    this.type = '',
    this.price = 0,
    this.description = '',
    this.address = "",
    this.city = '',
    this.country = '',
  }) {
    imagesName = [];
    displayImages = [];
    amenities = [];

    beds = {};
    bathroom = {};
    rating = 0;
  }
}
