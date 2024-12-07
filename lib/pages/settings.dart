import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<String> cities = [
    'رام الله',
    'نابلس',
    'الخليل',
    'بيت لحم',
    'طولكرم',
    'قلقيلية',
    'جنين',
    'سلفيت',
    'أريحا',
  ];

  String? _selectedCity;
  // ignore: unused_field
  String _password = '';
  // ignore: unused_field
  String _name = '';
  // ignore: unused_field
  int _age = 0;
  String _privacyOption = 'الجميع';
  // ignore: unused_field
  DateTime? _birthDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الإعدادات',
          style: GoogleFonts.elMessiri(
              color: const Color(0xFF002168),
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        backgroundColor: Color(0xFF0096FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('تعديل كلمة المرور'),
              leading: Icon(Icons.lock),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('تعديل كلمة المرور'),
                      content: TextField(
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'أدخل كلمة المرور الجديدة'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('حفظ'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text('إعدادات الخصوصية'),
              leading: Icon(Icons.privacy_tip),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('إعدادات الخصوصية'),
                      content: DropdownButton<String>(
                        value: _privacyOption,
                        items: <String>['الجميع', 'الأصدقاء', 'أنا فقط']
                            .map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _privacyOption = newValue!;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text('المدينة المقيم فيها'),
              leading: Icon(Icons.location_city),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('اختر المدينة'),
                      content: DropdownButton<String>(
                        value: _selectedCity,
                        items: cities.map((String city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedCity = value;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text('عمر المستخدم'),
              leading: Icon(Icons.calendar_today),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('أدخل عمرك'),
                      content: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _age = int.parse(value);
                          });
                        },
                        decoration: InputDecoration(hintText: 'أدخل عمرك'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('حفظ'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text('الاسم'),
              leading: Icon(Icons.person),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('أدخل اسمك'),
                      content: TextField(
                        onChanged: (value) {
                          setState(() {
                            _name = value;
                          });
                        },
                        decoration: InputDecoration(hintText: 'أدخل اسمك'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('حفظ'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text('تاريخ الميلاد'),
              leading: Icon(Icons.date_range),
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                ).then((date) {
                  setState(() {
                    _birthDate = date;
                  });
                });
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
