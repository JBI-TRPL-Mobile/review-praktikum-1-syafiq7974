import 'package:flutter/material.dart';

void main() {
  runApp(BookCatalogApp());
}

class BookCatalogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Buku',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(elevation: 2, color: Colors.indigoAccent),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/detail': (context) => DetailPage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}

// Halaman Home: Menampilkan daftar buku
class HomePage extends StatelessWidget {
  final List<Book> books = [
    Book(
      'Dunia Sophie',
      'Jostein Gaarder',
      'Dunia Sophie adalah sebuah novel filsafat yang diterbitkan pada tahun 1991 oleh penulis Norwegia, Jostein Gaarder. Cerita ini mengikuti Sophie Amundsen, seorang gadis berusia 14 tahun yang mulai menerima surat-surat misterius yang memperkenalkannya pada sejarah filsafat. Melalui perjalanan waktu, Sophie mempelajari ajaran-ajaran dari para filsuf besar seperti Socrates, Plato, Aristoteles, dan banyak lainnya. Novel ini menggabungkan fiksi dengan gagasan-gagasan filsafat dalam bentuk yang menarik dan mendidik, menjadikannya bacaan yang mengasyikkan sekaligus membuka wawasan tentang pemikiran filosofis Barat.',
    ),
    Book(
      'Laskar Pelangi',
      'Andrea Hirata',
      'sebuah novel karya Andrea Hirata yang diterbitkan pada tahun 2005. Novel ini mengisahkan perjuangan sekelompok anak sekolah dari desa miskin di Belitung, Indonesia, yang meskipun dalam keterbatasan, tetap gigih untuk meraih pendidikan. Dibimbing oleh dua guru yang berdedikasi, anak-anak ini menjalin persahabatan erat dan mengatasi berbagai tantangan seperti kemiskinan, kurangnya fasilitas, dan pandangan masyarakat. Novel ini menekankan tema ketekunan, persahabatan, dan pentingnya pendidikan. Laskar Pelangi menjadi salah satu novel terpopuler di Indonesia dan telah diadaptasi ke dalam film, teater, dan berbagai bentuk lainnya.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Katalog Buku',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => Navigator.pushNamed(context, '/about'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari buku...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                // Logic for search filtering (optional enhancement)
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigoAccent,
                      child: Icon(
                        Icons.book,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    title: Text(
                      books[index].title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(
                      books[index].author,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: books[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/about'),
        backgroundColor: Colors.indigoAccent,
        icon: Icon(Icons.info_outline),
        label: Text('Tentang'),
      ),
    );
  }
}

// Halaman Detail Buku: Menampilkan informasi detail buku
class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Book book = ModalRoute.of(context)!.settings.arguments as Book;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Buku'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: book.title, // Add hero animation
                  child: Icon(
                    Icons.book,
                    size: 100,
                    color: Colors.indigoAccent,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                book.title,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'oleh ${book.author}',
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              Text(
                book.description,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Halaman Tentang Aplikasi: Menampilkan informasi tentang aplikasi
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tentang Aplikasi')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.book, size: 100, color: Colors.indigoAccent),
              SizedBox(height: 20),
              Text(
                'Katalog Buku',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Versi 1.0.0',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Text(
                'Aplikasi ini dikembangkan oleh Syafiq Burhanuddin untuk menampilkan katalog buku sederhana dengan navigasi interaktif.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Divider(),
              Text(
                'Hak Cipta © 2024 Syafiq Burhanuddin. Semua hak dilindungi.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Model Buku
class Book {
  final String title;
  final String author;
  final String description;

  Book(this.title, this.author, this.description);
}
