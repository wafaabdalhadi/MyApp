import 'package:flutter/material.dart';
import 'package:flutter_application_5/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    home: BottomNavBar(), // استدعاء الشاشة الرئيسية
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('ar', 'AE'), // دعم اللغة العربية
    ],
    locale: const Locale('ar', 'AE'), // تعيين اللغة الافتراضية للعربية
  ));
}

class Healthrecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // إخفاء شارة الوضع التجريبي
      home: Directionality(
        textDirection: TextDirection.rtl, // تعيين الاتجاه من اليمين لليسار
        child: HealthRecord(),
      ),
    );
  }
}

class HealthRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'السجل الصحي',
          style: GoogleFonts.elMessiri(
            color: const Color(0xFF002168),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFF0096FF), // الأزرق الفاتح
      ),
      backgroundColor: Colors.white, // تعيين لون الخلفية إلى الأبيض
      body: Directionality(
        textDirection: TextDirection.rtl, // التأكد من أن كل المحتوى بالعربي
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'محتوى السجل الصحي هنا',
                style: GoogleFonts.elMessiri(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // تنفيذ بعض العمليات هنا
                },
                child: Text(
                  'تفاصيل أكثر',
                  style: GoogleFonts.elMessiri(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
