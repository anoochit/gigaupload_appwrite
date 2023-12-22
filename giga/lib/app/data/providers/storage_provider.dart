import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:giga/appwrite.dart';

class StorageProvider {
  /// get bucket files
  Future<FileList> getBucketFiles({required String bucketId}) async {
    return await storage.listFiles(bucketId: bucketId);
  }

  /// get file
  Future<Uint8List> getFile(
      {required String bucketId, required String fileId}) async {
    return await storage.getFileDownload(
      bucketId: bucketId,
      fileId: fileId,
    );
  }
}
