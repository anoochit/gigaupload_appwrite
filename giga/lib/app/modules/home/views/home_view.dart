import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../appwrite.dart';
import '../../../data/providers/storage_provider.dart';
import '../controllers/home_controller.dart';
import 'image_thumbnail_view.dart';

class HomeView extends GetView {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Giga Upload'),
              centerTitle: true,
            ),
            body: FutureBuilder(
              future: StorageProvider().getBucketFiles(bucketId: bucketId),
              builder:
                  (BuildContext context, AsyncSnapshot<FileList> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }

                if (snapshot.hasData) {
                  final files = snapshot.data!.files;

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: files.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ImageThumbnailView(
                        bucketId: bucketId,
                        id: files[index].$id,
                      );
                    },
                  );
                }

                return const Center(
                  child: Text('Loading...'),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                // upload
                final imagePicker = ImagePicker();
                final image =
                    await imagePicker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  StorageProvider()
                      .upload(
                          bucketId: bucketId,
                          fileData: await image.readAsBytes(),
                          filename: image.name)
                      .then((value) {
                    Get.snackbar('Upload completed', value.name);
                    controller.update();
                  });
                }
              },
              child: const Icon(Icons.upload),
            ),
          );
        });
  }
}
