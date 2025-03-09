import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkesh_marketer/constants/helpers.dart';
import 'package:turkesh_marketer/screens/auth/register.dart';
import 'package:turkesh_marketer/screens/conta.dart';
import 'package:turkesh_marketer/widgets/my_input.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  String? tokin;

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String? token;

class _LoginScreenState extends State<LoginScreen> {
  //
  bool isLoading = false;
  // formKey
  final _formKey = GlobalKey<FormState>();
  Future<void> _validateForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final response =
            await LoginUser(emailController.text, passwordController.text);

        setState(() {
          isLoading = false;
        });

        if (response.body.isNotEmpty) {
          var jsonResponse = jsonDecode(response.body);

          if (response.statusCode == 200) {
            // إظهار رسالة النجاح
            _showMessageDialog("success".tr(), "success_message".tr(),
                isSuccess: true);

            SharedPreferences prefs = await SharedPreferences.getInstance();

            // حفظ التوكن إذا كان موجودًا
            if (jsonResponse.containsKey('access_token')) {
              prefs.setString('token', jsonResponse['access_token']);
            }

            // حفظ بيانات المستخدم
            if (jsonResponse.containsKey('user')) {
              prefs.setString('name', jsonResponse['user']['name'] ?? '');
              prefs.setString('email', jsonResponse['user']['email'] ?? '');
            }

            // تحديد حالة تسجيل الدخول
            prefs.setBool('is_loggedin', true);

            // مسح الحقول بعد النجاح
            setState(() {
              emailController.clear();
              passwordController.clear();
            });
          } else {
            String errorMessage = transformErrors(jsonResponse);
            _showMessageDialog("Error Login", errorMessage);
          }
        } else {
          throw Exception("Empty response from server.");
        }
      } catch (error) {
        setState(() {
          isLoading = false;
        });

        print("Error: $error"); // طباعة الخطأ للمساعدة في معرفة السبب الحقيقي

        _showMessageDialog("error".tr(), "error_message".tr());
      }
    }
  }

  void _showMessageDialog(dynamic title, dynamic message,
      {bool isSuccess = false}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 00),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: AlertDialog(
            icon: isSuccess
                ? Icon(
                    Icons.check_circle,
                    color: Colors.teal,
                  )
                : Icon(
                    Icons.error_outline_outlined,
                    color: Colors.red[800],
                  ),
            title: Text(title),
            content: Text(message),
            actions: [
              MaterialButton(
                color: isSuccess ? null : Colors.red[800],
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق الـ Dialog
                },
                child: Text(
                  isSuccess ? "" : "OK",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation =
            CurvedAnimation(parent: animation, curve: Curves.easeInOut);
        return ScaleTransition(
          scale: curvedAnimation,
          child: child,
        );
      },
    );

    // إذا كانت العملية ناجحة، انتظر 3 ثوانٍ ثم انتقل إلى الصفحة الرئيسية
    if (isSuccess) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Conta()),
        );
      });
    }
  }

  // icon
  bool isShow = false;

  // Email controller]
  TextEditingController emailController = TextEditingController();
  // Password Controller
  TextEditingController passwordController = TextEditingController();
  // icon input
  bool iconOfOn = true;
  // chek box
  bool chekbOfOn = false;
  Future<http.Response> LoginUser(
    String email,
    String password,
  ) async {
    String url = 'https://turkish.weblayer.info/api/v1.0/auth/login';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'email': email,
          'password': password,
          'token': token ?? "",
        }),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      return response;
    } catch (e) {
      throw Exception("Failed to connect to the server");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // sized
            SizedBox(height: 40),
            // image
            Center(
              child: SvgPicture.asset(
                'assets/images/nlogo.svg',
                width: 100,
                height: 50,
              ),
            ),
            // sized
            SizedBox(height: 30),
            // title
            AutoSizeText(
              'welcom_auth'.tr(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
            // sized
            SizedBox(height: 20),
            // paragraph 1
            AutoSizeText(
              'disc_login'.tr(),
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.normal,
              ),
              maxLines: 1,
            ),
            // paragraph 2
            AutoSizeText(
              'login_sub_til'.tr(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
              maxLines: 1,
            ),
            // sized
            SizedBox(height: 50),

            // From
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // input Email
                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: Text("emailF".tr()),
                    ),
                    // class my input for email
                    MyInput(
                      // controller
                      yourController: emailController,
                      // hint
                      yourHintText: 'eml_enter'.tr(),
                      // validator
                      yourValidator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            isShow = true;
                          });
                          print(isShow);
                          return "requird_ino".tr();
                        }
                        return null;
                      },
                      // surfs icon
                      yourSurfsIcon: Icon(
                        isShow ? Icons.error_outline_outlined : null,
                        color: Colors.red[800],
                      ),
                    ),
                    SizedBox(height: 30),
                    // input Password
                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: Text("passwordF".tr()),
                    ),
                    // input
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "requird_ino".tr();
                        }
                        return null;
                      },
                      controller: passwordController,
                      cursorColor: Colors.grey,
                      obscureText: iconOfOn,
                      obscuringCharacter: '●',
                      decoration: InputDecoration(
                        // Enable
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        // Focused
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                iconOfOn = !iconOfOn;
                              });
                            },
                            child: Icon(
                              iconOfOn
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey.shade600,
                            )),
                        hintText: 'pass_enter'.tr(),
                        // Erorr
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        // border
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        // focused error border
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Checkbox Ant Text
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: chekbOfOn,
                                activeColor: Colors.red[800],
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    chekbOfOn = newValue ?? false;
                                  });
                                },
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  "remember".tr(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Forget Password
                        TextButton(
                          onPressed: () {},
                          child: AutoSizeText(
                            "forget".tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[800],
                              fontSize: 16,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            //  Sign In Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MaterialButton(
                padding: EdgeInsets.symmetric(vertical: 12),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.grey.shade300),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                minWidth: double.infinity,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black54
                    : Color(0xff475467),
                onPressed: () {
                  _validateForm();
                },
                child: Text(
                  "login".tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // sized
            SizedBox(height: 50),
            // Don't Have Account Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "dont_hav".tr(),
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "register".tr(),
                    style: TextStyle(
                      color: Colors.red[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
