import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadFileInput extends StatefulWidget {
  final TextEditingController? controller;

  const UploadFileInput({super.key, this.controller});

  @override
  _UploadFileInputState createState() => _UploadFileInputState();
}

class _UploadFileInputState extends State<UploadFileInput> {
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['svg', 'png', 'jpg'],
    );

    if (result != null) {
      setState(() {
        widget.controller?.text = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: _pickFile,
      readOnly: true,
      controller: widget.controller,
      cursorColor: Colors.grey[500],
      decoration: InputDecoration(
        hintText: "SVG, PNG, JPG (max. 800x400px)",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ElevatedButton(
            onPressed: _pickFile, // تشغيل نفس الدالة عند الضغط
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFEAECF0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.upload_file, color: Color(0xFF344054)),
                SizedBox(width: 4), // مسافة بين الأيقونة والنص
                Text("Upload", style: TextStyle(color: Color(0xFF344054))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
