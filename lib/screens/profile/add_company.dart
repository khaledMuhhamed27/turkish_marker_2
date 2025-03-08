import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turkesh_marketer/model/company_type_list.dart';
import 'package:turkesh_marketer/model/phone_number_class.dart';
import 'package:turkesh_marketer/ui/nav_bar_tabs/tab_bar_homs.dart';
import 'package:turkesh_marketer/widgets/input_name.dart';
import 'package:turkesh_marketer/widgets/my_button_form.dart';
import 'package:turkesh_marketer/widgets/my_input.dart';
import 'package:turkesh_marketer/widgets/tow_button_for_add.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _countryCountroller = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _adescriptionController = TextEditingController();
  final TextEditingController _websitUrlController = TextEditingController();
  // final TextEditingController _uploadFileController = TextEditingController();

  String? selectedName;
  Country? selectedCountry;

  List<Map<String, String>> countries = [];
  String _selectedPhoneCode = "+970"; // افتراضي فلسطين
  // final int _selectedCountryId = 237; // افتراضي فلسطين
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  // country and phone number
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

  //
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
          _countryCountroller.text = "${country.flagEmoji} ${country.name}";
          _selectedPhoneCode = "+${selectedCountry["intro"] ?? ""}";
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadCountriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        // Leading
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        // Back Text
        title: Text("Back"),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Sized
                SizedBox(height: 20),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/fet.svg',
                    width: 100,
                    height: 50,
                  ),
                ),
                SizedBox(height: 20),

                // Add Company Text
                Center(
                  child: Text(
                    "add_company".tr(),
                    style: TextStyle(
                      color: Color(0xFF101828),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Sized
                SizedBox(height: 6),
                // .
                Center(
                  child: Text(
                    "some".tr(),
                    style: TextStyle(
                      color: Color(0xFF475467),
                      fontSize: 16,
                    ),
                  ),
                ),
                // Sized
                SizedBox(height: 30),
                NameTileInput(InputTile: "com_name".tr()),
                MyInput(
                  yourController: _companyNameController,
                  yourHintText: "com_name".tr(),
                  yourValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "requird_ino".tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                // Company Type TEXT
                NameTileInput(InputTile: "com_type".tr()),
                // Company Type DropDown
                MyDropDownList(),
                //
                SizedBox(height: 20),
                // Description TEXT
                NameTileInput(InputTile: "com_desc".tr()),
                // Description Input
                MyInput(
                  yourController: _adescriptionController,
                  yourHintText: "com_desc_p".tr(),
                  minLine: 4,
                ),
                // Country
                SizedBox(height: 20),
                NameTileInput(InputTile: "select_cry".tr()),
                // Select Country
                _selectCountryMth(context),
                // Sized
                SizedBox(height: 20),
                // Website TEXT
                NameTileInput(InputTile: "website".tr()),
                // Url Input Method
                MyButtonForm(
                  yourkeybordType: TextInputType.url,
                  yourController: _websitUrlController,
                ),
                // Phone Number
                SizedBox(height: 20),
                NameTileInput(InputTile: "phone".tr()),
                // Input
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
                // Email
                SizedBox(height: 20),
                // Text
                NameTileInput(InputTile: "emailF".tr()),
                // \email Input
                MyInput(
                  yourController: _emailController,
                  yourHintText: "emailF".tr(),
                  yourValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "requird_ino".tr();
                    }
                    return null;
                  },
                ),
                // Billing Address
                SizedBox(height: 20),
                // Text
                NameTileInput(InputTile: "com_add".tr()),
                // Billing Address Input
                MyInput(
                  yourController: _addressController,
                  yourHintText: "com_til".tr(),
                  yourValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "requird_ino".tr();
                    }
                    return null;
                  },
                ),
                // Billing Address
                SizedBox(height: 20),
                // NameTileInput(InputTile: "The company's license files"),
                // UploadFileInput(
                //   controller: _uploadFileController,
                // ),
                SizedBox(height: 30),
                TwoButton(
                  onPressed1: () {
                    print("1");
                  },
                  onPressed2: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomTabBarHomeScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //########################################

  TextFormField _selectCountryMth(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "requird_ino".tr();
        }
        return null;
      },
      controller: _countryCountroller,
      readOnly: true,
      onTap: _selectCountry,
      decoration: InputDecoration(
        hintText: 'select_cry'.tr(),
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
          borderSide: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
