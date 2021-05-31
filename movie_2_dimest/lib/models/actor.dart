import 'package:equatable/equatable.dart';

class Actor extends Equatable {
  final String name;
  final String avatarURL;

  Actor._({required this.name, required this.avatarURL});
  factory Actor.fromMap(Map<String, dynamic> data) {
    return Actor._(
      name: data['name'],
      avatarURL: data['avatarURL'],
    );
  }

  @override
  List<Object> get props => [
        name,
        avatarURL,
      ];
}
