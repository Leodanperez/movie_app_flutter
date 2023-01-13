import 'package:movie_app/models/genres_model.dart';

class TVDetailsModel {
  final TVDetails? details;
  final String? error;

  TVDetailsModel({this.details, this.error});

  factory TVDetailsModel.fromJson(Map<String, dynamic> json) =>
      TVDetailsModel(
        details: TVDetails.fromJson(json),
        error: "",
      );

  factory TVDetailsModel.withError(String error) => TVDetailsModel(
    details: TVDetails(),
    error: error,
  );
}

class TVDetails {
  int? id;
  List<Genre>? genres;
  String? firstAirDate;
  String? overview;
  String? backDrop;
  String? poster;
  double? rating;
  String? name;
  int? numberOfEpisodes;
  int? numberOfSeasons;

  TVDetails({
    this.id,
    this.genres,
    this.firstAirDate,
    this.overview,
    this.backDrop,
    this.poster,
    this.rating,
    this.name,
    this.numberOfEpisodes,
    this.numberOfSeasons,
  });

  factory TVDetails.fromJson(Map<String, dynamic> json) => TVDetails(
    id: json['id'],
    genres: (json['genres'] as List).map((e) => Genre.fromJson(e)).toList(),
    firstAirDate: json['first_air_date'],
    overview: json['overview'],
    backDrop: json['backdrop_path'],
    poster: json['poster_path'],
    rating: json['vote_average'].toDouble(),
    name: json['name'],
    numberOfEpisodes: json['number_of_episodes'],
    numberOfSeasons: json['number_of_seasons'],
  );
}
