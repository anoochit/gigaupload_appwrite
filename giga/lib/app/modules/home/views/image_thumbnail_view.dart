import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/providers/storage_provider.dart';

class ImageThumbnailView extends GetView {
  const ImageThumbnailView(
      {Key? key, required this.bucketId, required this.id, required this.onTap})
      : super(key: key);

  final String bucketId;
  final String id;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StorageProvider().getFile(bucketId: bucketId, fileId: id),
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }

        if (snapshot.hasData) {
          return Card(
            elevation: 0.1,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Theme.of(context).colorScheme.onInverseSurface,
            child: InkWell(
              onTap: () => onTap(),
              child: Image.memory(
                snapshot.data!,
                fit: BoxFit.cover,
              ),
            ),
          );
        }

        return Card(
          elevation: 0.1,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Theme.of(context).colorScheme.onInverseSurface,
        );
      },
    );
  }
}
