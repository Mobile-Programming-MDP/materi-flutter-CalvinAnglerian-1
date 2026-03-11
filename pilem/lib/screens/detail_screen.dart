import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';

class DetailScreen extends StatelessWidget{
  final Movie movie;
  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              const Text(
                'Overview:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text (movie.overview),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Release Date:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Text(movie.releaseDate),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Rating:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Text(movie.voteAverage.toString()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Versi ada favoritenya

// import 'package:flutter/material.dart';
// import 'package:pilem/models/movie.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DetailScreen extends StatefulWidget {
//   final Movie movie;
//   const DetailScreen({super.key, required this.movie});

//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//   bool isFavorite = false;

//   void _toggleFavorite() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool favoriteStatus = !isFavorite;
//     prefs.setBool("favorite_${widget.movie.title}", favoriteStatus);
//     setState(() {
//       isFavorite = favoriteStatus;
//     });
//   }

//   void _loadFavoriteStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isFavorite = prefs.getBool("favorite_${widget.movie.title}") ?? false;
//     });
//   }

//   @override
//   void initState() {
//     _loadFavoriteStatus();
//     super.initState();
//   }
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(title: Text(widget.movie.title)),
//     body: Padding(
//       padding: const EdgeInsetsGeometry.all(8.0),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(
//               'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
//               height: 300,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Overview:',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text(movie.overview),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 const Icon(Icons.calendar_month, color: Colors.blue),
//                 const SizedBox(width: 10),
//                 const Text(
//                   'Release Date:',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(width: 10),
//                 Text(movie.releaseDate),
//               ],
//             ),
//             const SizedBox(height: 20),

//             Row(
//               children: [
//                 const Icon(Icons.star, color: Colors.amber),
//                 const SizedBox(width: 10),
//                 const Text(
//                   'Rating:',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(width: 10),
//                 Text(movie.voteAverage.toString()),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
