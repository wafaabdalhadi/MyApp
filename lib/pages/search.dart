import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// صفحة لعرض قائمة الصيدليات
class PharmacyPage extends StatelessWidget {
  final List<String> pharmacies = ['صيدلية 1', 'صيدلية 2', 'صيدلية 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'قائمة الصيدليات',
          style: GoogleFonts.elMessiri(
              color: Colors.white, fontSize: 24), // حجم الخط للرأس
        ),
        backgroundColor: Color(0xFF0096FF), // الأزرق الفاتح
      ),
      body: ListView(
        children: pharmacies.map((pharmacy) {
          return ListTile(
            title: Text(pharmacy, style: GoogleFonts.elMessiri(fontSize: 16)),
            leading: Icon(Icons.local_pharmacy),
            onTap: () {
              // Handle pharmacy selection
            },
          );
        }).toList(),
      ),
    );
  }
}

// صفحة لعرض قائمة الممرضين
class NursePage extends StatelessWidget {
  final List<String> nurses = ['ممرض 1', 'ممرض 2', 'ممرض 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'قائمة الممرضين',
          style: GoogleFonts.elMessiri(
              color: Colors.white, fontSize: 24), // حجم الخط للرأس
        ),
        backgroundColor: Color(0xFF0096FF), // الأزرق الفاتح
      ),
      body: ListView(
        children: nurses.map((nurse) {
          return ListTile(
            title: Text(nurse, style: GoogleFonts.elMessiri(fontSize: 16)),
            leading: Icon(Icons.person),
            onTap: () {
              // Handle nurse selection
            },
          );
        }).toList(),
      ),
    );
  }
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? searchOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'البحث',
          style: GoogleFonts.elMessiri(
              color: const Color(0xFF002168),
              fontWeight: FontWeight.bold,
              fontSize: 24), // حجم الخط للرأس
        ),
        backgroundColor: Color(0xFF0096FF), // الأزرق الفاتح
      ),
      backgroundColor: Colors.white, // تعيين لون الخلفية إلى الأبيض

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اختر عن ماذا تريد البحث:',
              style: GoogleFonts.elMessiri(fontSize: 18),
            ),
            // الصف مع صور الصيدلي والممرض
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PharmacyPage()),
                    );
                  },
                  child: Column(
                    children: [
                      Image.asset('images/pharmacist.png',
                          width: 80, height: 80), // صورة الصيدلي
                      SizedBox(height: 8),
                      Text('صيدلية',
                          style: GoogleFonts.elMessiri(fontSize: 16)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NursePage()),
                    );
                  },
                  child: Column(
                    children: [
                      Image.asset('images/nurse.png',
                          width: 80, height: 80), // صورة الممرض
                      SizedBox(height: 8),
                      Text('ممرض', style: GoogleFonts.elMessiri(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
