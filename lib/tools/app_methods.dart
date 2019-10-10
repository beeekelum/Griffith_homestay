import 'dart:io';

abstract class AppMethods {
  Future<List<String>> uploadListingImages(
      {String docID, List<File> imageList});

  Future<bool> updateListingImages({String docID, List<String> data});
}
