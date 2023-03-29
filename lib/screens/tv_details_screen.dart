import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/constants/style.dart';
import 'package:movie_app/models/hive_tv_model.dart';
import 'package:movie_app/models/tv/tv_model.dart';
import 'package:movie_app/screens/reviews.dart';
import 'package:movie_app/screens/trailers_screen.dart';
import 'package:movie_app/tv_widgets/similar_tv_widget.dart';
import 'package:movie_app/tv_widgets/tv_info.dart';

class TVsDetailsScreen extends StatefulWidget {
  const TVsDetailsScreen({Key? key, required this.tvShows, this.request})
      : super(key: key);
  final TVShows tvShows;
  final String? request;

  @override
  State<TVsDetailsScreen> createState() => _TVsDetailsScreenState();
}

class _TVsDetailsScreenState extends State<TVsDetailsScreen> {
  late Box<HiveTVModel> _tvWatchLists;

  @override
  void initState() {
    _tvWatchLists = Hive.box<HiveTVModel>('tv_lists');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tvShows.name!,
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
                        ? "${widget.tvShows.id}"
                        : "${widget.tvShows.id}${widget.request!}",
                    child: _buildPoster(),
                  ),
                ),
              ],
            ),
            TVsInfo(id: widget.tvShows.id!),
            SimilarTVs(id: widget.tvShows.id!),
            Reviews(id: widget.tvShows.id!, request: 'tv')
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
                          shows: 'tv',
                          id: widget.tvShows.id!,
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
                  onPressed: () {
                    HiveTVModel newValue = HiveTVModel(
                      id: widget.tvShows.id!,
                      rating: widget.tvShows.rating!,
                      name: widget.tvShows.name!,
                      backDrop: widget.tvShows.backDrop!,
                      poster: widget.tvShows.poster!,
                      overview: widget.tvShows.overview!,
                    );
                    _tvWatchLists.add(newValue);
                    _showAlertDialog();
                  },
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
                "https://image.tmdb.org/t/p/original/${widget.tvShows.backDrop}"),
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
                "https://image.tmdb.org/t/p/w200/${widget.tvShows.poster}"),
            fit: BoxFit.cover),
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Added to list'),
          content:
          Text("${widget.tvShows.name!} successfully added to watch list"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
