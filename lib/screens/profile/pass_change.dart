import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkesh_marketer/constants/helpers.dart';
import 'package:turkesh_marketer/widgets/appbar.dart';
import 'package:turkesh_marketer/widgets/input_name.dart';
import 'package:turkesh_marketer/widgets/my_input.dart';

class PassChangeScreen extends StatefulWidget {
  const PassChangeScreen({super.key});

  @override
  _PassChangeScreenState createState() => _PassChangeScreenState();
}

class _PassChangeScreenState extends State<PassChangeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isLoading = false;
  String? token;
  String? lpassword;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lpassword = prefs.getString('password');
    setState(() {
      token = prefs.getString('token');
      _passwordController.text = lpassword ?? "";
    });
  }

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) return;
    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showSnackbar("كلمة المرور الجديدة وتأكيدها غير متطابقين", false);
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("https://turkish.weblayer.info/api/v1.0/change-password"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "prev_password": _passwordController.text,
          "password": _newPasswordController.text,
          "password_confirmation": _confirmPasswordController.text,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(response.statusCode);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('password', _newPasswordController.text);
        _showSnackbar("تم تغيير كلمة المرور بنجاح!", true);
        _passwordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
        setState(() {
          _passwordController.text = lpassword ?? "";
          Navigator.pop(context);
        });
      } else {
        _showSnackbar(transformErrors(data), false);
      }
    } catch (error) {
      _showSnackbar("حدث خطأ غير متوقع، حاول لاحقًا.", false);
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showSnackbar(String message, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomAppBar(
                      myLiftIcon: Icons.arrow_back,
                      myRightButton: false,
                      titleScreen: "Change Password",
                      onLeftIconTap: () => Navigator.pop(context),
                    ),
                    NameTileInput(InputTile: "كلمة المرور الحالية*"),
                    MyInput(
                      yourController: _passwordController,
                      yourHintText: "أدخل كلمة المرور الحالية",
                      yourValidator: (value) =>
                          value!.isEmpty ? "هذا الحقل مطلوب" : null,
                    ),
                    SizedBox(height: 12),
                    NameTileInput(InputTile: "كلمة المرور الجديدة*"),
                    MyInput(
                      yourController: _newPasswordController,
                      yourHintText: "أدخل كلمة المرور الجديدة",
                      yourValidator: (value) =>
                          value!.isEmpty ? "هذا الحقل مطلوب" : null,
                    ),
                    SizedBox(height: 12),
                    NameTileInput(InputTile: "تأكيد كلمة المرور الجديدة*"),
                    MyInput(
                      yourController: _confirmPasswordController,
                      yourHintText: "أعد إدخال كلمة المرور الجديدة",
                      yourValidator: (value) =>
                          value!.isEmpty ? "هذا الحقل مطلوب" : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updatePassword,
                      child: Text("حفظ التعديلات"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
