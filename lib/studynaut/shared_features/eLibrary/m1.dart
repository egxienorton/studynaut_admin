import 'package:flutter/material.dart';

// import '../../UTILITIES/component/shimmers/leaderboard_placeholder.dart';
import 'components/shimmer_card.dart';

class Book {
  final String title;
  final String author;
  final String genre;
  final String image;
  final String description;
  final double rating;

  Book({
    required this.title,
    required this.author,
    required this.genre,
    required this.image,
    required this.description,
    required this.rating,
  });
}

class BookStore1 extends StatelessWidget {
  final List<String> genres = ['Romance', 'Art', 'Sci-Fi', 'Anime'];

  final Map<String, List<Book>> booksByGenre = {
    'Romance': [
      Book(
        title: 'Pride and Prejudice',
        author: 'Jane Austen',
        genre: 'Romance',
        image: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
        description:
            'Pride and Prejudice is a romantic novel of manners written by Jane Austen in 1813. The novel follows the character development of Elizabeth Bennet, the dynamic protagonist of the book who learns about the repercussions of hasty judgments and comes to appreciate the difference between superficial goodness and actual goodness. Its humour lies in its honest depiction of manners, education, marriage, and money during the Regency era in Great Britain.',
        rating: 4.5,
      ),
      Book(
        title: 'Pride and Prejudice',
        author: 'Jane Austen',
        genre: 'Romance',
        image: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
        description:
            'Pride and Prejudice is a romantic novel of manners written by Jane Austen in 1813. The novel follows the character development of Elizabeth Bennet, the dynamic protagonist of the book who learns about the repercussions of hasty judgments and comes to appreciate the difference between superficial goodness and actual goodness. Its humour lies in its honest depiction of manners, education, marriage, and money during the Regency era in Great Britain.',
        rating: 4.5,
      ),
      Book(
        title: 'Pride and Prejudice',
        author: 'Jane Austen',
        genre: 'Romance',
        image: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
        description:
            'Pride and Prejudice is a romantic novel of manners written by Jane Austen in 1813. The novel follows the character development of Elizabeth Bennet, the dynamic protagonist of the book who learns about the repercussions of hasty judgments and comes to appreciate the difference between superficial goodness and actual goodness. Its humour lies in its honest depiction of manners, education, marriage, and money during the Regency era in Great Britain.',
        rating: 4.5,
      ),
      Book(
        title: 'Pride and Prejudice',
        author: 'Jane Austen',
        genre: 'Romance',
        image: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
        description:
            'Pride and Prejudice is a romantic novel of manners written by Jane Austen in 1813. The novel follows the character development of Elizabeth Bennet, the dynamic protagonist of the book who learns about the repercussions of hasty judgments and comes to appreciate the difference between superficial goodness and actual goodness. Its humour lies in its honest depiction of manners, education, marriage, and money during the Regency era in Great Britain.',
        rating: 4.5,
      ),
      // Add more books here
    ],
    'Art': [
      Book(
        title: 'The Story of Art',
        author: 'E. H. Gombrich',
        genre: 'Art',
        image: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
        description:
            'The Story of Art, one of the most famous and popular books on art ever written, has been a world bestseller for over four decades. Attracted by the simplicity and clarity of his writing, readers of all ages and backgrounds have found in Professor Gombrich a true master, who combines knowledge and wisdom with a unique gift for communicating his deep love of the subject.',
        rating: 4.8,
      ),
      Book(
        title: 'The Story of Art',
        author: 'E. H. Gombrich',
        genre: 'Art',
        image: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
        description:
            'The Story of Art, one of the most famous and popular books on art ever written, has been a world bestseller for over four decades. Attracted by the simplicity and clarity of his writing, readers of all ages and backgrounds have found in Professor Gombrich a true master, who combines knowledge and wisdom with a unique gift for communicating his deep love of the subject.',
        rating: 4.8,
      ),
      Book(
        title: 'The Story of Art',
        author: 'E. H. Gombrich',
        genre: 'Art',
        image: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
        description:
            'The Story of Art, one of the most famous and popular books on art ever written, has been a world bestseller for over four decades. Attracted by the simplicity and clarity of his writing, readers of all ages and backgrounds have found in Professor Gombrich a true master, who combines knowledge and wisdom with a unique gift for communicating his deep love of the subject.',
        rating: 4.8,
      ),
      Book(
        title: 'The Story of Art',
        author: 'E. H. Gombrich',
        genre: 'Art',
        image: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
        description:
            'The Story of Art, one of the most famous and popular books on art ever written, has been a world bestseller for over four decades. Attracted by the simplicity and clarity of his writing, readers of all ages and backgrounds have found in Professor Gombrich a true master, who combines knowledge and wisdom with a unique gift for communicating his deep love of the subject.',
        rating: 4.8,
      ),
      // Add more books here
    ],
    'Sci-Fi': [
      Book(
        title: 'Dune',
        author: 'Frank Herbert',
        genre: 'Sci-Fi',
        image: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
        description:
            'Set in the distant future amidst a feudal interstellar society in which noble houses, in control of individual planets, owe allegiance to the Padishah Emperor, Dune tells the story of young Paul Atreides, whose noble family accepts the stewardship of the desert planet Arrakis. As this planet is the only source of the "spice" melange, the most important and valuable substance in the universe, control of Arrakis is a coveted—and dangerous—undertaking.',
        rating: 4.7,
      ),
      Book(
        title: 'Dune',
        author: 'Frank Herbert',
        genre: 'Sci-Fi',
        image: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
        description:
            'Set in the distant future amidst a feudal interstellar society in which noble houses, in control of individual planets, owe allegiance to the Padishah Emperor, Dune tells the story of young Paul Atreides, whose noble family accepts the stewardship of the desert planet Arrakis. As this planet is the only source of the "spice" melange, the most important and valuable substance in the universe, control of Arrakis is a coveted—and dangerous—undertaking.',
        rating: 4.7,
      ),
      Book(
        title: 'Dune',
        author: 'Frank Herbert',
        genre: 'Sci-Fi',
        image: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
        description:
            'Set in the distant future amidst a feudal interstellar society in which noble houses, in control of individual planets, owe allegiance to the Padishah Emperor, Dune tells the story of young Paul Atreides, whose noble family accepts the stewardship of the desert planet Arrakis. As this planet is the only source of the "spice" melange, the most important and valuable substance in the universe, control of Arrakis is a coveted—and dangerous—undertaking.',
        rating: 4.7,
      ),
      Book(
        title: 'Dune',
        author: 'Frank Herbert',
        genre: 'Sci-Fi',
        image: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
        description:
            'Set in the distant future amidst a feudal interstellar society in which noble houses, in control of individual planets, owe allegiance to the Padishah Emperor, Dune tells the story of young Paul Atreides, whose noble family accepts the stewardship of the desert planet Arrakis. As this planet is the only source of the "spice" melange, the most important and valuable substance in the universe, control of Arrakis is a coveted—and dangerous—undertaking.',
        rating: 4.7,
      ),

      // Add more books here
    ],
    'Anime': [
      Book(
        title: 'Jujustu kaise',
        author: 'Frank Herbert',
        genre: 'Sci-Fi',
        image: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
        description:
            'Set in the distant future amidst a feudal interstellar society in which noble houses, in control of individual planets, owe allegiance to the Padishah Emperor, Dune tells the story of young Paul Atreides, whose noble family accepts the stewardship of the desert planet Arrakis. As this planet is the only source of the "spice" melange, the most important and valuable substance in the universe, control of Arrakis is a coveted—and dangerous—undertaking.',
        rating: 4.7,
      ),
      Book(
        title: 'Naruto and friends',
        author: 'Frank Herbert',
        genre: 'Sci-Fi',
        image: 'https://covers.openlibrary.org/b/id/240727-S.jpg',
        description:
            'Set in the distant future amidst a feudal interstellar society in which noble houses, in control of individual planets, owe allegiance to the Padishah Emperor, Dune tells the story of young Paul Atreides, whose noble family accepts the stewardship of the desert planet Arrakis. As this planet is the only source of the "spice" melange, the most important and valuable substance in the universe, control of Arrakis is a coveted—and dangerous—undertaking.',
        rating: 4.7,
      ),
    ]
  };

  Widget _buildBookCard(Book book) {
    return Container(
      constraints:
          const BoxConstraints(maxWidth: 180, minHeight: 200, maxHeight: 280),
      child: Card(
        child: Column(
          children: [
            BookPlaceHolder(),
            // Image.network(
            //   book.image,
            //   height: 200.0,
            //   width: 100,
            //   fit: BoxFit.cover,
            // ),

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    book.author,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    book.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      const SizedBox(width: 5.0),
                      Text('${book.rating}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Book Store'),
        ),
        body: ListView.builder(
          itemCount: genres.length,
          itemBuilder: (BuildContext context, int index) {
            String genre = genres[index];
            List<Book> books = booksByGenre[genre]!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Because you love $genre'),
                ),
                const SizedBox(height: 10.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: books
                        .map((book) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: _buildBookCard(book),
                            ))
                        .toList(),
                  ),
                ),
              ],
            );
          },
        ),
      );
}
