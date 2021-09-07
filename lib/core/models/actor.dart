class Actor {
  final int id;
  final String name;
  final String? urlPhoto;

  Actor(this.id, this.name, this.urlPhoto);

  Actor.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        urlPhoto = json['profile_path'];
}
