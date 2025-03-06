import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PhoneNumberInput extends StatefulWidget {
  final TextEditingController controller;

  final String countryCode;
  final String phoneCode;
  final String? Function(String?)? validator;

  const PhoneNumberInput({
    super.key,
    required this.controller,
    required this.countryCode,
    required this.phoneCode,
    this.validator,
  });

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  late String _selectedPhoneCode;

  @override
  void initState() {
    super.initState();
    _selectedPhoneCode = widget.phoneCode;
  }

  @override
  void didUpdateWidget(covariant PhoneNumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.phoneCode != oldWidget.phoneCode) {
      setState(() {
        _selectedPhoneCode = widget.phoneCode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _selectedPhoneCode,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          child: TextFormField(
            controller: widget.controller,
            keyboardType: TextInputType.phone,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: 'phon_num_ent'.tr(),
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
            ),
          ),
        ),
      ],
    );
  }
}
