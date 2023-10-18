class Contact {
  String contact;

  Contact({
    required this.contact,
  });

  factory Contact.fromMap(Map json) => Contact(
        contact: json.toString(),
      );

  //
  static List<Contact> getList(Map json) {
    var list = json['contacts'] as List?;
    if (list != null) {
      return list.map((e) => Contact.fromMap(e as Map)).toList();
    }
    return [];
  }
}
