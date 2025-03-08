import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkesh_marketer/constants/helpers.dart';
import 'package:turkesh_marketer/model/phone_number_class.dart';
import 'package:turkesh_marketer/widgets/appbar.dart';
import 'package:turkesh_marketer/widgets/input_name.dart';
import 'package:turkesh_marketer/widgets/my_input.dart';
import 'dart:ui' as ui;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  bool isLoading = false;
  String? token;
  String? name;
  String? email;
  String? mobile;
  String? country;
  List<Map<String, String>> countries = [];
  String? _selectedPhoneCode; // افتراضي فلسطين
  int? _selectedCountryId;
  @override
  void initState() {
    super.initState();
    _loadUserData();
    loadCountriesData();
    getuserCountryId();
  }

  Future<void> getuserCountryId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? loadCountry = prefs.getInt("country_id");
    _selectedCountryId ??= loadCountry;
  }

// Load countr
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

// Select Country
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
          _countryController.text = country.name;
          _selectedPhoneCode = "+${selectedCountry["intro"] ?? ""}";
        });
      },
    );
  }

// Load User
  Future<void> _loadUserData() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    name = prefs.getString('name');
    email = prefs.getString('email');
    mobile = prefs.getString('mobile');
    country = prefs.getString('country');

    _selectedPhoneCode = prefs.getString("mobile_intro");

    try {
      setState(() {
        _nameController.text = name ?? "";
        _emailController.text = email ?? "";
        _phoneNumController.text = mobile ?? "";
        _countryController.text = country ?? "";
      });
    } catch (error) {
      _showErrorDialog("حدث خطأ أثناء تحميل البيانات.", false);
    }

    setState(() {
      isLoading = false;
    });
  }

// Update Function
  Future<void> _updateProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await _sendUpdateRequest(
        _nameController.text,
        _emailController.text,
        _selectedCountryId!,
        _phoneNumController.text,
        _selectedPhoneCode!,
      );

      if (response.body.isNotEmpty) {
        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200) {
          print(response.statusCode);
          _showErrorDialog("تم تحديث الملف الشخصي بنجاح!", true);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('name', jsonResponse['user']['name'] ?? '');
          prefs.setString('email', jsonResponse['user']['email'] ?? '');
          prefs.setString("country", _countryController.text);
          prefs.setString(
              "mobile", jsonResponse['user']['user_info']['mobile'] ?? '');
          prefs.setString("mobile_intro",
              jsonResponse['user']['user_info']['mobile_intro']);
        } else {
          String errorMessage = transformErrors(jsonResponse);
          _showErrorDialog(errorMessage, false);

          //    _showErrorDialog(errorMessage, false);
        }
      } else {
        throw Exception("Empty response from server.");
      }
    } catch (error) {
      _showErrorDialog("حدث خطأ غير متوقع، حاول لاحقًا.", false);
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<http.Response> _sendUpdateRequest(
    String name,
    String email,
    int countryId,
    String mobile,
    String mobileIntro,
  ) async {
    return await http.put(
      Uri.parse("https://turkish.weblayer.info/api/v1.0/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        'country_id': countryId,
        'mobile_intro': mobileIntro,
        'mobile': mobile,
      }),
    );
  }

  void _showErrorDialog(String message, bool success) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(success ? "نجاح" : "خطأ"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (success)
                Navigator.of(context).pop(); // إغلاق الشاشة بعد التحديث الناجح
            },
            child: Text("موافق"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == 'ar'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomAppBar(
                          myLiftIcon: Icons.arrow_back,
                          myRightButton: false,
                          titleScreen: "edit_prof".tr(),
                          onLeftIconTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(height: 20),
                        NameTileInput(InputTile: "name".tr()),
                        MyInput(
                          yourController: _nameController,
                          yourHintText: "chng_name".tr(),
                          yourValidator: (value) {
                            if (value == null || value.isEmpty) {
                              return "requird_ino".tr();
                            }
                            return null;
                          },
                        ),
                        // Email
                        SizedBox(height: 12),
                        NameTileInput(InputTile: "emailF".tr()),
                        MyInput(
                          yourController: _emailController,
                          yourHintText: "chng_email".tr(),
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
                          controller: _countryController,
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
                        // Phone Number
                        SizedBox(height: 12),
                        NameTileInput(InputTile: "phone".tr()),
                        PhoneNumberInput(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "requird_ino".tr();
                            }
                            return null;
                          },
                          controller: _phoneNumController,
                          countryCode: _selectedPhoneCode ??
                              "+970", // تعيين قيمة افتراضية
                          phoneCode: _selectedPhoneCode ?? "+970",
                        ),
                        SizedBox(height: 70),
                        MaterialButton(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          color: Color(0xff475467),
                          minWidth: MediaQuery.of(context).size.width * 9,
                          onPressed: () async {
                            if (_selectedCountryId == null) {
                              _showErrorDialog(
                                  "يرجى اختيار الدولة قبل الحفظ", false);
                              return;
                            } else {
                              _updateProfile();
                            }
                          },
                          child: Text(
                            "save_chnag".tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
