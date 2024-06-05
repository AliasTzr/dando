class Advise{
  final int id, type;
  final String title, description;
  const Advise({required this.id,
    required this.type,
    required this.title,
    required this.description});

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
    };
  }
}