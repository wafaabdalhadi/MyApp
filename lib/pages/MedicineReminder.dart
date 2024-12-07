import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MedicineReminder(),
    );
  }
}

class MedicineReminder extends StatefulWidget {
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _medicineNameController = TextEditingController();
  final _pharmacistNoteController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          // التعامل مع النقر على الإشعار هنا
        });
  }

  Future<void> _showNotification(DateTime dateTime) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'medicine_reminder_channel', 'تذكير بتناول الدواء',
        channelDescription: 'هذه القناة تحتوي على تذكيرات بتناول الأدوية',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true);
    var iosPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'تذكير بتناول الدواء',
        'حان الوقت لتناول دوائك',
        tz.TZDateTime.from(dateTime, tz.local),
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تذكير مواعيد تناول الدواء',
          style: GoogleFonts.elMessiri(
              color: const Color(0xFF002168),
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        backgroundColor: const Color(0xFF0096FF),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _patientNameController,
                  decoration: InputDecoration(
                    labelText: 'اسم المريض',
                    labelStyle: GoogleFonts.elMessiri(fontSize: 14),
                  ),
                  style: GoogleFonts.elMessiri(fontSize: 18),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الرجاء إدخال اسم المريض';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _medicineNameController,
                  decoration: InputDecoration(
                    labelText: 'اسم الدواء',
                    labelStyle: GoogleFonts.elMessiri(fontSize: 14),
                  ),
                  style: GoogleFonts.elMessiri(fontSize: 18),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الرجاء إدخال اسم الدواء';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _pharmacistNoteController,
                  decoration: InputDecoration(
                    labelText: 'ملاحظات الصيدلي',
                    labelStyle: GoogleFonts.elMessiri(fontSize: 14),
                  ),
                  style: GoogleFonts.elMessiri(fontSize: 18),
                ),
                ListTile(
                  title: Text(
                    DateFormat('yyyy-MM-dd').format(_startDate),
                    style: GoogleFonts.elMessiri(fontSize: 18),
                  ),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _startDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != _startDate) {
                      setState(() {
                        _startDate = picked!;
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    DateFormat('yyyy-MM-dd').format(_endDate),
                    style: GoogleFonts.elMessiri(fontSize: 18),
                  ),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _endDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != _endDate) {
                      setState(() {
                        _endDate = picked!;
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    _time.format(context),
                    style: GoogleFonts.elMessiri(fontSize: 18),
                  ),
                  trailing: Icon(Icons.access_time),
                  onTap: () async {
                    TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: _time,
                    );
                    if (picked != null && picked != _time) {
                      setState(() {
                        _time = picked;
                      });
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_endDate.isBefore(_startDate)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'تاريخ النهاية يجب أن يكون بعد أو يساوي تاريخ البداية')),
                          );
                          return;
                        }

                        for (int i = 0;
                        i <= _endDate.difference(_startDate).inDays;
                        i++) {
                          final reminderDate =
                          _startDate.add(Duration(days: i));
                          final reminderDateTime = DateTime(
                            reminderDate.year,
                            reminderDate.month,
                            reminderDate.day,
                            _time.hour,
                            _time.minute,
                          );
                          _showNotification(reminderDateTime);
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('تم ضبط جميع التذكيرات بنجاح')),
                        );
                      }
                    },
                    child: Text(
                      'إرسال الموعد',
                      style: GoogleFonts.elMessiri(
                          color: Colors.white, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 3, 46, 121),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
