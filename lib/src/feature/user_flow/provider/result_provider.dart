import 'package:flutter_riverpod/flutter_riverpod.dart';

final classResultProvider = StateProvider.family<Map<String, dynamic>, int> ((ref, classNo)=> {});