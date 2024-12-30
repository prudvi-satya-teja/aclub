class Club {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> members;

  Club({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.members,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      members: List<String>.from(json['members'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'members': members,
    };
  }
}
