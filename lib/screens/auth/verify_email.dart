import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkesh_marketer/screens/request_screens/import_screen.dart';

class VerifyEmail extends StatefulWidget {
  final String email;

  const VerifyEmail({super.key, required this.email});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  Future<void> _verifyCode() async {
    setState(() => isLoading = true);

    try {
      var response = await http.post(
        Uri.parse('https://turkish.weblayer.info/api/v1.0/verify-email'),
        body: jsonEncode({
          'email': widget.email,
          'otp': otpController.text,
        }),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      setState(() => isLoading = false);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('is_verified', true);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("تم تأكيد البريد الإلكتروني بنجاح!")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ImportSc(
                    type: 'importer',
                  )),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("الرمز غير صحيح، حاول مرة أخرى")),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      print("خطأ أثناء التحقق من الرمز: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تأكيد البريد الإلكتروني")),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("تم إرسال رمز إلى بريدك الإلكتروني: ${widget.email}"),
                    SizedBox(height: 20),
                    TextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "أدخل الرمز",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _verifyCode,
                      child: Text("تأكيد"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
