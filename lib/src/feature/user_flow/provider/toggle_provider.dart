import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../admin_flow/provider/toggle_provider.dart';

final selectedScreenProvider = StateProvider<int>((ref)=> 0);

final userIsLoading = StateProvider<bool>((ref)=>false);
final userSelectedScreenProvider = StateProvider((ref)=>0);

final versityListProvider = StateProvider<List<Map<String, dynamic>>>((ref)=>[]);

final filteredVersitiesProvider = StateProvider<List<Map<String, dynamic>>>((ref) {
  final searchQuery = ref.watch(searchQueryProvider);
  final versities = ref.watch(versityListProvider);

  if (searchQuery.isEmpty) {
    return versities;
  } else {
    return versities.where((versity) {
      return versity['institute'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          versity['subject'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }
});