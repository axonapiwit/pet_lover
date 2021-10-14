class Post {
  String postName;
  String petName;
  String postCategory;
  String petCategory;
  String character;
  String nurture;
  String species;
  String urlImage;
  String location;
  String confirm;
  String description;
  String health;
  String createdBy;
  String status;

  Post({
    this.petName = '',
    this.postName = '',
    this.postCategory = '',
    this.petCategory = '',
    this.character = '',
    this.nurture = '',
    this.species = '',
    this.urlImage = '',
    this.location = '',
    this.confirm = '',
    this.description = '',
    this.health = '',
    this.createdBy = '',
    this.status = '',
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      petName: json['petName'],
      postName: json['postName'],
      postCategory: json['postCategory'],
      petCategory: json['petCategory'],
      character: json['character'],
      nurture: json['nurture'],
      species: json['species'],
      urlImage: json['urlImage'],
      location: json['location'],
      confirm: json['confirm'],
      description: json['description'],
      health: json['health'],
      createdBy: json['createdBy'],
      status: json['status'],
    );
  }
}
