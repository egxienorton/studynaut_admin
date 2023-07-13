import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String genre;
  final String image;
  final String description;
  final double rating;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.image,
    required this.description,
    required this.rating,
  });
}

class BookStore2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Store',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Book Store'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('books').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            List<Book> books = snapshot.data!.docs.map((doc) {
              return Book(
                id: doc.id,
                title: doc['title'],
                author: doc['author'],
                genre: doc['genre'],
                image: doc['image'],
                description: doc['description'],
                rating: doc['rating'].toDouble(),
              );
            }).toList();

            Map<String, List<Book>> booksByGenre = Map.fromIterable(
              ['romance', 'art', 'scifi'],
              key: (genre) => genre,
              value: (genre) =>
                  books.where((book) => book.genre == genre).toList(),
            );

            return ListView.builder(
              itemCount: booksByGenre.length,
              itemBuilder: (BuildContext context, int index) {
                String genre = booksByGenre.keys.toList()[index];
                List<Book> books = booksByGenre[genre]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        genre,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: books
                            .map((book) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _buildBookCard(book),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildBookCard(Book book) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.network(
              book.image,
              height: 200.0,
              width: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              book.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              book.author,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16.0,
                ),
                const SizedBox(width: 5.0),
                Text(
                  book.rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      width: 150.0,
    );
  }
}
