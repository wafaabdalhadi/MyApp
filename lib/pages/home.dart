import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection:
        TextDirection.rtl, // التأكد من أن الاتجاه من اليمين لليسار
        child: HomePage(),
      ),
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 90, 137, 240), // الأزرق الملكي
        textTheme:
        GoogleFonts.elMessiriTextTheme(), // تطبيق خط ElMessiri للنصوص
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الصفحة الرئيسية',
          style: GoogleFonts.elMessiri(
              color: const Color(0xFF002168),
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        backgroundColor: Color(0xFF0096FF), // الأزرق الملكي
      ),
      backgroundColor: Colors.white, // تعيين لون الخلفية إلى الأبيض

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // الصف الذي يحتوي على صورة الصيدلي وصورة الطبيب
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // التوجيه إلى صفحة طلب الدواء عند الضغط على صورة الصيدلي
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MedicineOrderPage()),
                    );
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'images/pharmacy.png', // صورة الصيدلي
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'طلب الدواء',
                        style: GoogleFonts.elMessiri(
                          fontSize: 18,
                          color: Color(0xFF0096FF), // نفس لون الصورة
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30), // المسافة بين الصيدلي والطبيب
                GestureDetector(
                  onTap: () {
                    // التوجيه إلى صفحة الأطباء المتاحين عند الضغط على صورة الطبيب
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoctorListPage()),
                    );
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'images/as.png', // صورة الطبيب
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'استشارة طبيب',
                        style: GoogleFonts.elMessiri(
                          fontSize: 18,
                          color: Color(0xFF0096FF), // نفس لون الصورة
                        ),
                      ),
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

// صفحة عرض الأطباء المتاحين
class DoctorListPage extends StatelessWidget {
  final List<String> doctors = ['دكتور 1', 'دكتور 2', 'دكتور 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'قائمة الأطباء المتاحين',
          style: GoogleFonts.elMessiri(
              color: const Color(0xFF002168), fontSize: 24),
        ),
        backgroundColor: Color(0xFF0096FF), // الأزرق الملكي
      ),
      body: Directionality(
        textDirection: TextDirection.rtl, // تحديد الاتجاه من اليمين لليسار
        child: ListView.builder(
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(doctors[index],
                  style: GoogleFonts.elMessiri(fontSize: 18)),
              leading: Icon(Icons.person),
              onTap: () {
                // يمكنك إضافة عملية التفاعل هنا عند الضغط على اسم الطبيب
              },
            );
          },
        ),
      ),
    );
  }
}

// صفحة طلب الدواء
class MedicineOrderPage extends StatefulWidget {
  @override
  _MedicineOrderPageState createState() => _MedicineOrderPageState();
}

class _MedicineOrderPageState extends State<MedicineOrderPage> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> orders = [];
  String medicineName = '';
  int quantity = 1;
  String patientName = '';
  String parmsyname = '';
  String note = '';

  void _addOrder() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        orders.add({
          'name': medicineName,
          'quantity': quantity,
          'patient': patientName,
          'parmsyname': parmsyname,
          'note': note,
        });
      });
      _formKey.currentState!.reset();
    }
  }

  void _deleteOrder(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تأكيد الحذف'),
          content: Text('هل أنت متأكد أنك تريد حذف هذا الطلب؟'),
          actions: [
            TextButton(
              child: Text('لا'),
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق مربع الحوار
              },
            ),
            TextButton(
              child: Text('نعم'),
              onPressed: () {
                setState(() {
                  orders.removeAt(index); // حذف الطلب
                });
                Navigator.of(context).pop(); // إغلاق مربع الحوار
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' إرسال طلبات الدواء للصيدلي',
          style: GoogleFonts.elMessiri(
              color: const Color(0xFF002168)), // لون الخط أبيض
        ),
        backgroundColor: Color(0xFF0096FF), // الأزرق الفاتح
      ),
      body: Directionality(
        textDirection: TextDirection.rtl, // تحديد الاتجاه من اليمين لليسار
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField('اسم الدواء', (value) {
                      medicineName = value!;
                    }),
                    _buildTextField('الكمية ', (value) {
                      quantity = int.parse(value!);
                    }, keyboardType: TextInputType.number),
                    _buildTextField('اسم المريض', (value) {
                      patientName = value!;
                    }),
                    _buildTextField('اسم الصيدلية ', (value) {
                      parmsyname = value!;
                    }),
                    _buildTextField('ملاحظة المريض ', (value) {
                      note = value!;
                    }),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _addOrder,
                        child: Text('ارسال الطلب',
                            style: GoogleFonts.elMessiri(
                                color: Colors.white)), // لون الخط أبيض
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 8, 39, 92),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Card(
                      color: Color(0xFFCEE9F0), // الأزرق الفاتح 2
                      child: ListTile(
                        title: Text(
                          '${order['name']} (${order['quantity']})',
                          style: GoogleFonts.elMessiri(
                              fontSize: 18,
                              color: Color.fromARGB(
                                  255, 0, 30, 179)), // لون الخط بلون بلو أوشن
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'المريض: ${order['patient']}',
                              style: GoogleFonts.elMessiri(
                                  color: const Color.fromRGBO(68, 138, 255,
                                      1)), // لون الخط بلون بلو أوشن
                            ),
                            SizedBox(height: 5),
                            Text(
                              'الصيدلية: ${order['parmsyname']}',
                              style: GoogleFonts.elMessiri(
                                  color: const Color.fromRGBO(
                                      0, 0, 0, 1)), // لون الخط بالأسود
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteOrder(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved,
      {TextInputType? keyboardType}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Color(0xFF0096FF), // الأزرق الفاتح
        borderRadius: BorderRadius.circular(25), // حدود بيضاوية
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
          GoogleFonts.elMessiri(color: Colors.white), // لون النص أبيض
          border: InputBorder.none, // إزالة الحدود الافتراضية
          contentPadding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 15), // تحكم في الحشو
        ),
        style: GoogleFonts.elMessiri(
            color: Color.fromARGB(255, 6, 0, 179),
            fontSize: 18), // لون الخط بلون بلو أوشن وزيادة حجم الخط
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'يرجى إدخال $label';
          }
          return null;
        },
        onSaved: onSaved,
        keyboardType: keyboardType,
        textDirection: TextDirection.rtl, // النص من اليمين لليسار
      ),
    );
  }
}
