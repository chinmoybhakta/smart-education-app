import 'package:flutter_riverpod/flutter_riverpod.dart';

final isObscureProvider = StateProvider.autoDispose<bool>((ref) => true);
final isLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);
final isClickedProvider = StateProvider.autoDispose<bool>((ref) => false);