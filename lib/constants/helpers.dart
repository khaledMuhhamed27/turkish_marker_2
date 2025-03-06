// /// Function to transform error messages into a formatted string.
// ///
// /// Accepts either a single error message or a map containing multiple errors for different fields.
// ///
// /// [errors] A map containing error messages for each input field.
// /// [singleError] An optional single error message.
// ///
// /// Returns a formatted error message string.
// String transformErrors(Map<String, dynamic>? errors, {String? singleError}) {
//   // Using StringBuffer for better performance when building the error string.
//   final StringBuffer messageBuffer = StringBuffer();

//   // Add the single error message if it exists and is not empty.
//   if (singleError != null && singleError.trim().isNotEmpty) {
//     messageBuffer.writeln('- $singleError');
//   }

//   // Ensure errors is not null and contains valid data.
//   if (errors != null && errors.isNotEmpty) {
//     errors.forEach((key, value) {
//       // Check if the error value is a list of strings before processing.
//       if (value is List) {
//         for (var msg in value) {
//           if (msg is String && msg.trim().isNotEmpty) {
//             messageBuffer.writeln('- $msg');
//           }
//         }
//       }
//     });
//   }

//   // Return the final formatted error message, removing any trailing spaces.
//   return messageBuffer.toString().trim();
// }
String transformErrors(Map<String, dynamic> jsonResponse, ) {
  if (jsonResponse.containsKey('errors')) {
    final errors = jsonResponse['errors'] as Map<String, dynamic>;
    return errors.entries.map((entry) {
      final messages = entry.value;
      if (messages is List) {
        return messages.map((msg) => '- $msg').join('\n');
      } else if (messages is String) {
        return '- $messages';
      }
      return '';
    }).join('\n');
  }
  if (jsonResponse.containsKey('message')) {
    return jsonResponse['message'];
  }
  return 'حدث خطأ غير معروف';
}
