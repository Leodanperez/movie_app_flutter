import 'package:flutter/material.dart';
import 'package:movie_app/constants/style.dart';
import 'package:movie_app/models/movie/movie_model.dart';
import 'package:movie_app/movie_widgets/movie_info.dart';
import 'package:movie_app/movie_widgets/similar_movie_widget.dart';
import 'package:movie_app/screens/reviews.dart';
import 'package:movie_app/screens/trailers_screen.dart';

class MoviesDetailsScreen extends StatefulWidget {
  const MoviesDetailsScreen({Key? key, required this.movie, this.request})
      : super(key: key);
  final Movie movie;
  final String? request;

  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}

class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.title!,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildBackDrop(),
                Positioned(
                  top: 150,
                  left: 30,
                  child: Hero(
                    tag: widget.request == null
                        ? "${widget.movie.id}"
                        : "${widget.movie.id}${widget.request!}",
                    child: _buildPoster(),
                  ),
                ),
              ],
            ),
            MovieInfo(id: widget.movie.id!),
            SimilarMovies(id: widget.movie.id!),
            Reviews(id: widget.movie.id!, request: 'movie')
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.redAccent,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => TrailersScreen(
                          shows: 'movie',
                          id: widget.movie.id!,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.play_circle_fill_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Watch Trailers',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Style.secondColor,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.list_alt_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Add To Lists',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildBackDrop() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
            image: NetworkImage(
                "https://image.tmdb.org/t/p/original/${widget.movie.backDrop}"),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildPoster() {
    return Container(
      width: 120,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
            image: NetworkImage(
                "https://image.tmdb.org/t/p/w200/${widget.movie.poster}"),
            fit: BoxFit.cover),
      ),
    );
  }
}
