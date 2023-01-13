class GenreModel {
  final List<Genre>? genres;
  final String? error;

  GenreModel({this.genres, this.error});

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        genres: (json['genres'] as List).map((e) => Genre.fromJson(e)).toList(),
        error: "",
      );

  factory GenreModel.withError(String error) => GenreModel(
        genres: [],
        error: error,
      );
}

class Genre {
  int? id;
  String? name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json['id'],
        name: json['name'],
      );
}
