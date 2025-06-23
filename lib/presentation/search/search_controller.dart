import 'package:get/get.dart';
import '../../model/search.dart';
import '../../repo/i_music_repository.dart';

class SearchControllerController extends GetxController {
  final IMusicRepo musicRepo = Get.find<IMusicRepo>();

  //search var

  // Using ''.obs creates a non-nullable RxString, so we cannot assign null to it later.
  //  If null values are needed (e.g., to differentiate between "no input" and an empty string),
  //  use RxnString() instead, which supports null.

  //var searchText = ''.obs;
  var searchText = RxnString();

  var isLoading = false.obs;

  // Creates a reactive boolean with an initial value false.
  // This is shorthand for RxBool(false).

  var i = RxBool(false);

  // Explicitly creates a reactive boolean with initial value false.
  // Both are functionally the same; using `.obs` is just shorter syntax.

  var error = RxnString();
  var searchData = Rxn<Search>();

  @override
  void onInit() {
    debounce<String?>(
      searchText,
      (value) => searchQuery(value ?? ''),
      time: const Duration(milliseconds: 600),
    );
    super.onInit();
  }

  void searchQuery(String query) async {
    if (query.isEmpty) {
      searchData.value = null;
      return;
    }

    try {
      isLoading.value = true;

      //works same as isLoading
      // i.value = true;
      error.value = null;

      final searchResult = await musicRepo.searchArtist(query);
      searchData.value = searchResult;
    } catch (e) {
      error.value = "Something went wrong. Try again.";
    } finally {
      isLoading.value = false;
    }
  }
}
