class Character {
  late int charld;
  late String name;
  late String image;
  late String gender;
  late String species;
  late String statusIfDeadOrA1ive;
  Character.fromJson(Map<String,dynamic>json)
  {
    charld=json['id'];
    name=json['name'];
    image=json['image'];
    gender=json['gender'];
    species=json['species'];
    statusIfDeadOrA1ive=json['status'];
  }
}