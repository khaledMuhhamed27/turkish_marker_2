import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkesh_marketer/screens/auth/login.dart';
import 'package:turkesh_marketer/screens/profile/pass_change.dart';
import 'package:turkesh_marketer/screens/profile/select_lang_screen.dart';
import 'package:turkesh_marketer/screens/profile/add_company.dart';
import 'package:turkesh_marketer/screens/profile/user_info.dart';
import 'package:turkesh_marketer/widgets/appbar.dart';
import 'package:turkesh_marketer/widgets/my_list_tile.dart';
import 'package:http/http.dart' as http;

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                myLiftIcon: Icons.arrow_back,
                myRightButton: false,
                titleScreen: "profile_sc".tr(),
                onLeftIconTap: () {
                  Navigator.pop(context);
                },
              ),
              // sized
              SizedBox(height: 30),
              // text
              Text(
                "prfile_set".tr(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              // LisTile
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Change Language
                    MyListTileF(
                      iconUrl: "assets/images/edt.svg",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                        );
                      },
                      titleC: 'edit_profile'.tr(),
                    ), // Change Language
                    MyListTileF(
                      iconUrl: "assets/images/q.svg",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCompanyScreen(),
                          ),
                        );
                        print("Form Company");
                      },
                      titleC: 'add_company'.tr(),
                    ), // Change Language
                    MyListTileF(
                      iconUrl: "assets/images/qa.svg",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PassChangeScreen()));
                      },
                      titleC: 'change_password'.tr(),
                    ),
                    // Change Language
                    MyListTileF(
                      iconUrl: "assets/images/aqa.svg",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SelectLangScreen()));
                      },
                      titleC: "change_lang".tr(),
                    ),
                    MyListTiletheme(),
                  ],
                ),
              ),
              // sized
              SizedBox(height: 30),
              // text
              Text(
                "turkis".tr(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              // sized
              SizedBox(height: 10),
              // Contact us
              MyListTileF(
                iconUrl: "assets/images/sas.svg",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
                titleC: 'contact'.tr(),
              ),
              //Our partners
              MyListTileF(
                iconUrl: "assets/images/rf.svg",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
                titleC: 'our_partners'.tr(),
              ),
              //Terms and Condation
              MyListTileF(
                iconUrl: "assets/images/gt.svg",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
                titleC: 'terms_cond'.tr(),
              ),
              // Index of products
              MyListTileF(
                iconUrl: "assets/images/yh.svg",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
                titleC: 'index_prod'.tr(),
              ),
              // sized
              SizedBox(height: 30),
              // Other
              MyListTileF(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
                titleC: 'other'.tr(),
              ),
              // Membership Plans
              MyListTileF(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
                iconUrl: 'assets/images/tag.svg',
                titleC: 'membership_plans'.tr(),
              ),
              // Agents
              MyListTileF(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                  print("Form Edit");
                },
                iconUrl: 'assets/images/gtr.svg',
                titleC: 'agents'.tr(),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 120, top: 20),
                child: MaterialButton(
                  elevation: 0,
                  height: 44,
                  minWidth: double.infinity,
                  color: Color(0xffFEF3F2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: _logout,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "logout".tr(),
                        style: TextStyle(
                          color: Color(0xFF912018),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.logout, color: Color(0xFF912018))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottom navbar
    );
  }

  Future<void> _logoutAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenm = prefs.getString('token') ?? "";
    final String url =
        'https://turkish.weblayer.info/api/v1.0/auth/logout'; // تأكد من صحة الرابط الخاص بك

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $tokenm', // أرسل التوكن في الهيدر
        },
      );

      if (response.statusCode == 200) {
        print("تم تسجيل الخروج بنجاح ${response.body}");
      } else {
        print("فشل تسجيل الخروج: ${response.body}");
      }
    } catch (e) {
      print("Error during logout API call: $e");
      throw Exception("فشل الاتصال بالخادم");
    }
  }

  Future<void> _logout() async {
    try {
      // عرض رسالة تأكيد الخروج
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("هل أنت متأكد من تسجيل الخروج؟"),
            actions: [
              // زر نعم
              TextButton(
                onPressed: () async {
                  // استدعاء API لتسجيل الخروج
                  await _logoutAPI();

                  // مسح التوكن وبيانات المستخدم من SharedPreferences
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.remove('token');
                  await prefs.setBool('is_loggedin', false);
                  Navigator.pop(context);
                  // إعادة توجيه المستخدم إلى شاشة تسجيل الدخول
                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text("نعم"),
              ),
              // زر إلغاء
              TextButton(
                onPressed: () async {
                  try {
                    Navigator.pop(context); // إغلاق الحوار أولًا
                  } catch (e) {
                    print("خطأ أثناء تسجيل الخروج: $e");
                  }
                },
                child: Text("إلغاء"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print("Error during logout: $e");
      // في حال حدوث أي خطأ
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("خطأ"),
            content: Text("حدث خطأ أثناء تسجيل الخروج. يرجى المحاولة لاحقًا."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("موافق"),
              ),
            ],
          );
        },
      );
    }
  }
}
