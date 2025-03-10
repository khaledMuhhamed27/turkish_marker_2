import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PhoneNumberInput extends StatefulWidget {
  final TextEditingController controller;

  final String countryCode;
  final String phoneCode;
  final bool? enable;
  final String? Function(String?)? validator;

  const PhoneNumberInput({
    super.key,
    this.enable,
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
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? widget.enable == true
                        ? Colors.grey
                        : Colors.grey.shade800
                    : widget.enable == true
                        ? Colors.grey
                        : Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _selectedPhoneCode,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).brightness == Brightness.dark
                  ? widget.enable == true
                      ? Colors.white
                      : Colors.grey.shade500
                  : widget.enable == true
                      ? Colors.black
                      : Colors.grey.shade500,
            ),
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          child: TextFormField(
            enabled: widget.enable,
            cursorColor: Colors.grey,
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
