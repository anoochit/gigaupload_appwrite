import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:giga/appwrite.dart';

/// A custom exception thrown when storage-related errors occur.
class StorageException implements Exception {
  /// A detailed message describing the error.
  final String message;

  /// Creates a new [StorageException] with the given [message].
  StorageException(this.message);

  @override
  String toString() => 'StorageException: $message';
}

/// A class that provides access to storage operations.
class StorageProvider {
  /// Retrieves a list of files within the specified bucket.
  ///
  /// Throws a [StorageException] if an error occurs during retrieval.
  Future<FileList> getBucketFiles({required String bucketId}) async {
    try {
      return await storage.listFiles(bucketId: bucketId);
    } on Exception catch (e) {
      throw StorageException('Failed to retrieve bucket files: $e');
    }
  }

  /// Retrieves the contents of a file as a [Uint8List].
  ///
  /// Throws a [StorageException] if an error occurs during retrieval.
  Future<Uint8List> getFile(
      {required String bucketId, required String fileId}) async {
    return await storage.getFileDownload(
      bucketId: bucketId,
      fileId: fileId,
    );
  }

  /// Retrieves a thumbnail representation of a file.
  ///
  /// Throws a [StorageException] if an error occurs during retrieval.
  Future<Uint8List> getFileThumbnail({
    required String bucketId,
    required String fileId,
  }) async {
    return await storage.getFilePreview(
      bucketId: bucketId,
      fileId: fileId,
      width: 512,
    );
  }

  /// Uploads a file to storage.
  ///
  /// Throws a [StorageException] if an error occurs during upload.
  Future<File> upload({
    required String bucketId,
    required Uint8List fileData,
    required String filename,
  }) async {
    try {
      return await storage.createFile(
        bucketId: bucketId,
        fileId: ID.unique(),
        file: InputFile.fromBytes(bytes: fileData, filename: filename),
      );
    } on Exception catch (e) {
      throw StorageException('Failed to upload files: $e');
    }
  }
}
