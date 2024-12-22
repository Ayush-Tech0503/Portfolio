bool validatePreEmail(String? email) {
  final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
  return email == '' || emailRegex.hasMatch(email.toString());
}