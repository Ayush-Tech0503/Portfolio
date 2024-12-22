String? validateAccountHolder(value) {
  if (value.isEmpty) {
    return 'Please Enter name';
  }
  return null;
}
String? validateDOB(value) {
  if (value.isEmpty) {
    return 'Please Enter DOB';
  }
  return null;
}
String? validateMobile(value) {
  String patttern = r'(^[6-9]\d{9}$)';
  RegExp regExp = RegExp(patttern);
  if (value.length == 0) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null;
}
String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email is required';
  }

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(email)) {
    return 'Enter a valid email address';
  }

  return null;
}

String? validatePreEmail(String? email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (email != null && !emailRegex.hasMatch(email)) {
    return 'Enter a valid email address';
  }
  return null;
}

bool validatePreEmail1(String? email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return email == '' || emailRegex.hasMatch(email.toString());
}


String? validatePassword(value) {
  String password;
  if (value.isEmpty) {
    return 'Please enter a password';
  }
  if (value.length < 5) {
    return 'Password must be at least 5 characters';
  }
  password = value;
  return null;
}


//-----------------------------
String? validateReviewRating(value) {
  if (value.isEmpty) {
    return 'Review is required';
  } else if (value.length < 3) {
    return 'Review must be at least 3 characters';
  }
  return null;
}