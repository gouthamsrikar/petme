class Pet {
 String? id;
  String? petName;
  String? gender;
  String? category;
  String? color;
  String? breed;
  String? weight;
  List<String>? photoUrls;
  String? price;
  String? description;
  String? ownerName;
  String? ownerPhone;
  String? ownerLocation;
  String? ownerImageUrl;

  Pet(
      {this.id,
      this.petName,
      this.gender,
      this.category,
      this.color,
      this.breed,
      this.weight,
      this.photoUrls,
      this.price,
      this.description,
      this.ownerName,
      this.ownerPhone,
      this.ownerLocation,
      this.ownerImageUrl});

  Pet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    petName = json['pet_name'];
    gender = json['gender'];
    category = json['category'];
    color = json['color'];
    breed = json['breed'];
    weight = json['weight'];
    photoUrls = json['photo_urls'].cast<String>();
    price = json['price'];
    description = json['description'];
    ownerName = json['owner_name'];
    ownerPhone = json['owner_phone'];
    ownerLocation = json['owner_location'];
    ownerImageUrl = json['owner_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pet_name'] = this.petName;
    data['gender'] = this.gender;
    data['category'] = this.category;
    data['color'] = this.color;
    data['breed'] = this.breed;
    data['weight'] = this.weight;
    data['photo_urls'] = this.photoUrls;
    data['price'] = this.price;
    data['description'] = this.description;
    data['owner_name'] = this.ownerName;
    data['owner_phone'] = this.ownerPhone;
    data['owner_location'] = this.ownerLocation;
    data['owner_image_url'] = this.ownerImageUrl;
    return data;
  }
}
