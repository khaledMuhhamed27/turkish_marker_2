import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class CountryPickerInput extends StatefulWidget {
  final Function(String countryCode, String phoneCode) onCountrySelected;
  final String? Function(String?)? yourValidator;

  const CountryPickerInput(
      {super.key, required this.onCountrySelected, this.yourValidator, required List<Map<String, String>> countries});

  @override
  State<CountryPickerInput> createState() => _CountryPickerInputState();
}

class _CountryPickerInputState extends State<CountryPickerInput> {
  String? _selectedCountry;
  String? _countryCode;
  String? _phoneCode;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.yourValidator,
      readOnly: true,
      controller: _controller,
      style: TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        hintText: 'Select Country',
        hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(12)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(12)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(12)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(12)),
        suffixIcon: Icon(Icons.keyboard_arrow_down),
      ),
      onTap: () {
        showCountryPicker(
          showPhoneCode: true,
          context: context,
          onSelect: (Country country) {
            setState(() {
              _selectedCountry = country.name;
              _countryCode = country.countryCode;
              _phoneCode = "+${country.phoneCode}";
              _controller.text = _selectedCountry!;
            });

            widget.onCountrySelected(_countryCode!, _phoneCode!);
          },
        );
      },
    );
  }
}
