import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_picker/country_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkesh_marketer/constants/helpers.dart';
import 'package:turkesh_marketer/model/phone_number_class.dart';
import 'package:turkesh_marketer/screens/auth/verify_email.dart';
import 'package:turkesh_marketer/widgets/input_name.dart';
import 'package:turkesh_marketer/widgets/long_text.dart';
import 'package:turkesh_marketer/widgets/my_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  List<Map<String, String>> countries = [];
  String _selectedPhoneCode = "+970"; // افتراضي فلسطين
  final int _selectedCountryId = 237; // افتراضي فلسطين
  bool isLoading = false;
  String? token;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadCountriesData();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    phoneNumController.dispose();
    countryController.dispose();
    super.dispose();
  }

  Future<void> loadCountriesData() async {
    try {
      String data = await rootBundle.loadString('assets/json/countries.json');
      Map<String, dynamic> jsonResult = json.decode(data);

      if (jsonResult.containsKey('countries') &&
          jsonResult['countries'] is List) {
        setState(() {
          countries = List<Map<String, String>>.from(
            jsonResult['countries'].map((e) => Map<String, String>.from(e)),
          );
        });
      }
    } catch (e) {
      print("Error loading country data: $e");
    }
  }

  Future<void> _validateForm() async {
    var cleanedPhoneNumber = phoneNumController.text.replaceAll(" ", "");

    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final response = await registerUser(
          nameController.text,
          emailController.text,
          passwordController.text,
          confirmPassController.text,
          _selectedCountryId,
          cleanedPhoneNumber,
          _selectedPhoneCode,
        );

        setState(() {
          isLoading = false;
        });

        if (response.body.isNotEmpty) {
          var jsonResponse = jsonDecode(response.body);

          if (response.statusCode == 201) {
            var email = emailController.text;

            print("✅ التسجيل ناجح، سيتم إرسال رمز التحقق إلى: $email");
            print(token);
            // إظهار رسالة النجاح
            _showErrorDialog(
                email, "Registration successful! Click OK to go to Home", true);

            SharedPreferences prefs = await SharedPreferences.getInstance();

            // حفظ التوكن إذا كان موجودًا
            if (jsonResponse.containsKey('token')) {
              token = jsonResponse['token'];

              // استخدام SharedPreferences لحفظ التوكن
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('token', token!);
              print("✅ التوكن تم حفظه بنجاح: $token");

              // استخدام setState لتحديث UI بعد حفظ التوكن
              setState(() {
                // لا داعي لوضع العملية غير المتزامنة هنا
              });
              await sendVerificationCode(
                email,
              );
            }

            // حفظ بيانات المستخدم
            if (jsonResponse.containsKey('user')) {
              prefs.setString('name', jsonResponse['user']['name'] ?? '');
              prefs.setString('email', jsonResponse['user']['email'] ?? '');
              prefs.setString(
                  "mobile", jsonResponse['user']['user_info']['mobile'] ?? '');
              prefs.setString("mobile_intro",
                  jsonResponse['user']['user_info']['mobile_intro']);
              prefs.setString("password", passwordController.text);
              prefs.setInt("country_id",
                  jsonResponse['user']['user_info']['country_id']);
              prefs.setString("country", countryController.text);
            }

            // تحديد حالة تسجيل الدخول
            prefs.setBool('is_loggedin', true);

            // مسح الحقول بعد النجاح
            setState(() {
              nameController.clear();
              emailController.clear();
              passwordController.clear();
              confirmPassController.clear();
              phoneNumController.clear();
              countryController.clear();
              _selectedPhoneCode = "+970";
            });
          } else {
            String errorMessage = transformErrors(jsonResponse);
            _showErrorDialog(null, errorMessage, false);
          }
        } else {
          throw Exception("Empty response from server.");
        }
      } catch (error) {
        setState(() {
          isLoading = false;
        });

        print("Error: $error"); // طباعة الخطأ للمساعدة في معرفة السبب الحقيقي

        _showErrorDialog(
          null,
          "An unexpected error occurred, please try again later.",
          false,
        );
      }
    }
  }

  // Show Error Function
  void _showErrorDialog(
      String? email, String message, bool registrationSuccess) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: AlertDialog(
            title: Text(registrationSuccess ? "Success" : "Registration Error"),
            content: Text(message),
            actions: [
              MaterialButton(
                color: registrationSuccess ? Colors.teal : Colors.red[800],
                onPressed: () {
                  if (registrationSuccess) {
                    print("🔄 سيتم الانتقال إلى صفحة تأكيد البريد الإلكتروني.");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyEmail(
                                  email: email.toString(),
                                )));
                  } else {
                    print("🚫 هناك خطأ، لن يتم الانتقال.");

                    Navigator.pop(context);
                  }
                },
                child: Text(
                  registrationSuccess ? "Success" : "OK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
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
  }

  Future<http.Response> registerUser(
    String name,
    String email,
    String password,
    String confirmPassword,
    int countryId,
    String mobile,
    String mobileIntro,
  ) async {
    String url = 'https://turkish.weblayer.info/api/v1.0/auth/signup';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
          'country_id': countryId,
          'mobile_intro': mobileIntro,
          'mobile': mobile,
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

  void _selectCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        final selectedCountry = countries.firstWhere(
          (element) => element["code"] == country.countryCode,
          orElse: () => {"intro": ""},
        );
        setState(() {
          countryController.text = country.name;
          _selectedPhoneCode = "+${selectedCountry["intro"] ?? ""}";
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        centerTitle: false,
        title: Text("back".tr(), style: TextStyle(fontSize: 20)),
      ),
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.red[800],
              ),
            )
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 80),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/images/nlogo.svg',
                            width: 100,
                            height: 50,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      AutoSizeText(
                        "sign_tit".tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextTitle(),
                      SizedBox(height: 40),
                      NameTileInput(InputTile: "name".tr()),
                      MyInput(
                        yourController: nameController,
                        yourHintText: 'ent_name'.tr(),
                        yourValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return "requird_ino".tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      NameTileInput(InputTile: "eml_enter_l".tr()),
                      MyInput(
                        yourController: emailController,
                        yourHintText: 'eml_enter'.tr(),
                        yourValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return "requird_ino".tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      NameTileInput(InputTile: "passwordFQ".tr()),
                      MyInput(
                        yourController: passwordController,
                        yourHintText: 'pass_enter'.tr(),
                        yourValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return "requird_ino".tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      NameTileInput(InputTile: "passwordFQW".tr()),
                      MyInput(
                        yourController: confirmPassController,
                        yourHintText: 'pass_enter'.tr(),
                        yourValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return "requird_ino".tr();
                          }
                          return null;
                        },
                      ),
                      // Select Countr
                      SizedBox(height: 20),
                      NameTileInput(InputTile: "select_cry".tr()),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "requird_ino".tr();
                          }
                          return null;
                        },
                        controller: countryController,
                        readOnly: true,
                        onTap: _selectCountry,
                        decoration: InputDecoration(
                          hintText: 'select_cry_yoour'.tr(),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          // Erorr
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
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
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      NameTileInput(InputTile: "phon_num".tr()),
                      PhoneNumberInput(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "requird_ino".tr();
                          }
                          return null;
                        },
                        controller: phoneNumController,
                        countryCode: _selectedPhoneCode,
                        phoneCode: _selectedPhoneCode,
                      ),
                      SizedBox(height: 20),
                      LongTextM(),
                      MyButtonR(
                        myOnPressed: () {
                          _validateForm();
                        },
                      ),
                      SizedBox(height: 30),
                      Center(child: HuText()),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> sendVerificationCode(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token'); // استرجاع التوكن إذا كان null
    print(token);
    if (token == null) {
      print("⚠️ التوكن غير متوفر، تأكد من تسجيل المستخدم أولًا.");
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('https://turkish.weblayer.info/api/v1.0/verify-email/send'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print("🔹 بيانات الإرسال: $token");

      print("📩 استجابة السيرفر: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        print("✅ تم إرسال رمز التحقق بنجاح إلى $email");
      } else {
        print("❌ فشل في إرسال رمز التحقق: ${response.body}");
      }
    } catch (e) {
      print("⚠️ خطأ أثناء إرسال رمز التحقق: $e");
    }
  }
}
