RegExp gmail = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

bool Validate_Form(List<String> data) {
  if(!gmail.hasMatch(data[2])) return false;
  for (int i = 0; i < 13; i++) {
    if (data[i] == "") return false;
  }
  return true;
}