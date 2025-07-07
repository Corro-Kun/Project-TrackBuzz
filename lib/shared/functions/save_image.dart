import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';

Future<String> saveImage(String img) async {
  final Directory? appDocDir = await getExternalStorageDirectory();
  final String path = appDocDir!.path;

  final File imageFile = File(img);

  final random = Random();
  const chars =
      'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLLLLLZXCVBNM1234567890';

  String nameFile = String.fromCharCodes(
    Iterable.generate(
      30,
      (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ),
  );

  final Directory imagesDir = Directory('$path/images');
  if (!await imagesDir.exists()) {
    await imagesDir.create(recursive: true);
  }

  final File newImage = await imageFile.copy('$path/images/$nameFile');

  await imageFile.delete();

  return newImage.path.toString();
}
