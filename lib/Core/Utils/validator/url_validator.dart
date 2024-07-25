String? validateUrl(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter a valid URL';
  }

  // Regular expression to match a basic URL format
  // Validator for localhost URLs (matches http://localhost, http://127.0.0.1, http://[::1], etc.)
  RegExp localhostUrlRegExp = RegExp(
    r'^https?://(localhost|127\.0\.0\.1|\[::1\]|(0{1,2}0{0,2}0{0,2}0{0,2}0{0,2}0{0,2}0{0,2}1))(:[0-9]{1,5})?/?',
    caseSensitive: false,
    multiLine: false,
  );

// Validator for general server URLs (matches http://example.com, https://www.example.com, etc.)
  RegExp serverUrlRegExp = RegExp(
    r'^(http|https):\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}(:[0-9]{1,5})?(\/\S*)?$',
    caseSensitive: false,
    multiLine: false,
  );
  print("entered");
  if (!(localhostUrlRegExp.hasMatch(value) ||
      serverUrlRegExp.hasMatch(value))) {
    return 'Enter a valid URL';
  }
  return null;
}
