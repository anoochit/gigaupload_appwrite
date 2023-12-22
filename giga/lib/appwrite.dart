import 'package:appwrite/appwrite.dart';

const bucketId = "files";
const databaseId = "giga";
const collectionId = "files";

Client client = Client()
    .setEndpoint('http://10.0.2.2/v1')
    .setProject('6583b45e37f6c7eaeb2c')
    .setSelfSigned(
      status: true,
    );

Storage storage = Storage(client);
