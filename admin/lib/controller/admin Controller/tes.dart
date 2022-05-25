void main() {
  List<Language> languages = [
    Language(id: 1, name: "java", isComplex: true, numOfUsers: 1000),
    Language(id: 2, name: "python", isComplex: false, numOfUsers: 5000),
    Language(id: 3, name: "javascript", isComplex: true, numOfUsers: 800),
    Language(id: 4, name: "dart", isComplex: false, numOfUsers: 80000),
  ];

  for (Language l in languages) {
    print(l.name);
  }

  var newList = languages.where((language) {
    return language.numOfUsers > 1000;
  }).toList();

  print(newList.length);

  for (Language l in newList) {
    print(l.numOfUsers);
  }
}

class Language {
  int id;
  String name;
  bool isComplex;
  int numOfUsers;

  Language(
      {required this.name,
      required this.id,
      required this.numOfUsers,
      required this.isComplex});
}
