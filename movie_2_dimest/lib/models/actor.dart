class Actor {
  final String name;
  final String avatarURL;

  Actor._({required this.name, required this.avatarURL});
  factory Actor.fromMap(Map<String, dynamic> data) {
    return Actor._(
      name: data['name'],
      avatarURL: data['avatarURL'],
    );
  }
}
