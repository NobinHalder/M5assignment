import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ৪টা আলাদা image + title
    final courses = [
      {
        "image": "https://up.yimg.com/ib/th/id/OIP.J2gX8tZrt5UYN-3HKGGTRgHaEK?pid=Api&rs=1&c=1&qlt=95&w=289&h=162",
        "title": "Full Stack Web Development with JavaScript (MERN)"
      },
      {
        "image": "https://up.yimg.com/ib/th/id/OIP.nQoCN1Qx_ziCkzkiky0QbwHaEK?pid=Api&rs=1&c=1&qlt=95&w=289&h=162",
        "title": "Full Stack Web Development with Python, Django & React"
      },
      {
        "image": "https://up.yimg.com/ib/th/id/OIP.41hw1s5Fk5WYAAdiNq4XagHaEK?pid=Api&rs=1&c=1&qlt=95&w=289&h=162",
        "title": "Full Stack Web Development with ASP.Net Core"
      },
      {
        "image": "https://tse4.mm.bing.net/th/id/OIP.L1jnuDJd3MOSogSwwbQHmgHaFj?pid=Api&P=0&h=220",
        "title": "SQA: Manual & Automated Testing"
      },
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Course Grid'),
        backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2, // প্রতিটি row তে 2টা কার্ড
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.75, // কার্ডের আকার সামঞ্জস্য করতে
            children: courses.map((course) {
              return _buildCourseCard(course["image"]!, course["title"]!);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// 🟩 কোর্স কার্ড (ছবি → ব্যাজ → টাইটেল)
Widget _buildCourseCard(String imageUrl, String title) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 📸 ছবি
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: Image.network(
            imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 6),

        // 🔹 ব্যাজ (ছবির নিচে)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: const [
              _InfoBadge(
                icon: Icons.batch_prediction,
                text: 'ব্যাচ ১১',
                color: Colors.redAccent,
              ),
              SizedBox(width: 6),
              _InfoBadge(
                icon: Icons.people,
                text: '৬ সিট বাকি',
                color: Colors.blueAccent,
              ),
              SizedBox(width: 6),
              _InfoBadge(
                icon: Icons.access_time,
                text: '৬ দিন বাকি',
                color: Colors.green,
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // 📝 টাইটেল
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

// 🟦 ব্যাজ উইজেট
class _InfoBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _InfoBadge({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        child: Row(
          children: [
            Icon(icon, size: 12, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
