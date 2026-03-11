import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/screens/detail_screen.dart';
import 'package:pilem/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final ApiService _apiService = ApiService();
  List<Movie> _favoriteMovie = [];

  Future<void> _loadFavoriteMovie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   _favoriteMovie = movieList.where((movie){
    //     return prefs.getBool('favorite_$(movie.name)') ?? false;
    //   }).toList();
    // });

    final List<Map<String, dynamic>> allMoviesData = await _apiService
        .getAllMovies();

    final movies = allMoviesData.map((e) => Movie.fromJson(e)).toList();

    setState(() {
      _favoriteMovie = movies.where((movie) {
        return prefs.getBool('favorite_${movie.title}') ?? false;
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFavoriteMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite')),
      body: _favoriteMovie.isEmpty
          ? const Center(
              child: Text(
                "Belum ada film favorit.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _favoriteMovie.length,
              itemBuilder: (context, index) {
                final Movie movie = _favoriteMovie[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(movie: movie),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(movie.posterPath),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
