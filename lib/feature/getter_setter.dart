class StudentIdentity {
  static final StudentIdentity _instance = StudentIdentity._internal();

  var _identity;
  var _class;
  Map <String, dynamic> _resultData = {};
  Map <String, dynamic> _data = {};
  Map <String, dynamic> _one_data = {};
  Map <String, dynamic> _two_data = {};
  Map <String, dynamic> _three_data = {};
  Map <String, dynamic> _four_data = {};
  Map <String, dynamic> _five_data = {};
  Map <String, dynamic> _six_data = {};
  Map <String, dynamic> _seven_data = {};
  Map <String, dynamic> _eight_data = {};
  Map <String, dynamic> _nine_data = {};
  Map <String, dynamic> _ten_data = {};

  StudentIdentity._internal();
  factory StudentIdentity() {
    return _instance;
  }

  int getIdentity() {
    return _identity;
  }

  void setIdentity(int _identity) {
    this._identity = _identity;
  }

  String getClass() {
    return _class;
  }

  void setClass(String _class) {
    this._class = _class;
  }

  double getCGPA() {
    int count = 0;
    double sum = 0.0;

    List<dynamic> classWiseGpa = _resultData.values.toList();

    for (dynamic value in classWiseGpa) {
      double? gpa = double.tryParse(value.toString());
      if (gpa != null && gpa != 0) {
        sum += gpa;
        count++;
      }
    }

    if (count == 0) return 0.0;

    double cgpa = sum / count;
    return (cgpa * 100).roundToDouble() / 100;
  }

  void setResultData(Map<String, dynamic> _resultData) {
    this._resultData = _resultData;
  }

  Map<String, dynamic> getResultData() {
    return this._resultData;
  }

  Map<String, dynamic> getData() {
    return this._data;
  }

  void setData(Map<String, dynamic> _data) {
    this._data = _data;
  }

  Map<String, dynamic> getTenData() {
    return _ten_data;
  }

  void setTenData(Map<String, dynamic> _ten_data) {
    this._ten_data = _ten_data;
  }

  Map<String, dynamic> getNineData() {
    return _nine_data;
  }

  void setNineData(Map<String, dynamic> _nine_data) {
    this._nine_data = _nine_data;
  }

  Map<String, dynamic> getEightData() {
    return _eight_data;
  }

  void setEightData(Map<String, dynamic> _eight_data) {
    this._eight_data = _eight_data;
  }

  Map<String, dynamic> getSevenData() {
    return _seven_data;
  }

  void setSevenData(Map<String, dynamic> _seven_data) {
    this._seven_data = _seven_data;
  }

  Map<String, dynamic> getSixData() {
    return _six_data;
  }

  void setSixData(Map<String, dynamic> _six_data) {
    this._six_data = _six_data;
  }

  Map<String, dynamic> getFiveData() {
    return _five_data;
  }

  void setFiveData(Map<String, dynamic> _five_data) {
    this._five_data = _five_data;
  }

  Map<String, dynamic> getFourData() {
    return _four_data;
  }

  void setFourData(Map<String, dynamic> _four_data) {
    this._four_data = _four_data;
  }

  Map<String, dynamic> getThreeData() {
    return _three_data;
  }

  void setThreeData(Map<String, dynamic> _three_data) {
    this._three_data = _three_data;
  }

  Map<String, dynamic> getTwoData() {
    return _two_data;
  }

  void setTwoData(Map<String, dynamic> _two_data) {
    this._two_data = _two_data;
  }

  Map<String, dynamic> getOneData() {
    return _one_data;
  }

  void setOneData(Map<String, dynamic> _one_data) {
    this._one_data = _one_data;
  }
}