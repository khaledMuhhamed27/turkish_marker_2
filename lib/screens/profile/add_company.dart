import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turkesh_marketer/model/company_type_list.dart';
import 'package:turkesh_marketer/model/phone_number_class.dart';
import 'package:turkesh_marketer/widgets/input_name.dart';
import 'package:turkesh_marketer/widgets/my_button_form.dart';
import 'package:turkesh_marketer/widgets/my_input.dart';
import 'package:turkesh_marketer/widgets/tow_button_for_add.dart';
import 'package:turkesh_marketer/widgets/upload_file_input.dart';

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
  final TextEditingController _uploadFileController = TextEditingController();

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
                    "Add Company",
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
                    "Share where you’ve worked on your profile",
                    style: TextStyle(
                      color: Color(0xFF475467),
                      fontSize: 16,
                    ),
                  ),
                ),
                // Sized
                SizedBox(height: 30),
                NameTileInput(InputTile: "Company Name*"),
                MyInput(
                  yourController: _companyNameController,
                  yourHintText: "Edit Your Name",
                  yourValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "this input is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                // Company Type TEXT
                NameTileInput(InputTile: "Company Type*"),
                // Company Type DropDown
                MyDropDownList(),
                //
                SizedBox(height: 20),
                // Description TEXT
                NameTileInput(InputTile: "Description*"),
                // Description Input
                MyInput(
                  yourController: _adescriptionController,
                  yourHintText: "Enter a description...",
                  minLine: 4,
                ),
                // Country
                SizedBox(height: 20),
                NameTileInput(InputTile: "Select Counter*"),
                // Select Country
                _selectCountryMth(context),
                // Sized
                SizedBox(height: 20),
                // Website TEXT
                NameTileInput(InputTile: "Website*"),
                // Url Input Method
                MyButtonForm(
                  yourkeybordType: TextInputType.url,
                  yourController: _websitUrlController,
                ),
                // Phone Number
                SizedBox(height: 20),
                NameTileInput(InputTile: "Phone Number*"),
                // Input
                PhoneNumberInput(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "this input is required";
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
                NameTileInput(InputTile: "Email*"),
                // \email Input
                MyInput(
                  yourController: _emailController,
                  yourHintText: "Email Here",
                  yourValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "this input is required";
                    }
                    return null;
                  },
                ),
                // Billing Address
                SizedBox(height: 20),
                // Text
                NameTileInput(InputTile: "Billing address*"),
                // Billing Address Input
                MyInput(
                  yourController: _addressController,
                  yourHintText: "What is your title?",
                  yourValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "this input is required";
                    }
                    return null;
                  },
                ),
                // Billing Address
                SizedBox(height: 20),
                NameTileInput(InputTile: "The company's license files"),
                UploadFileInput(
                  controller: _uploadFileController,
                ),
                SizedBox(height: 30),
                TwoButton(
                  onPressed: () {},
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
          return "this input is required";
        }
        return null;
      },
      controller: _countryCountroller,
      readOnly: true,
      onTap: _selectCountry,
      decoration: InputDecoration(
        hintText: 'Select your country',
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
