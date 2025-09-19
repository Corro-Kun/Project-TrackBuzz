import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trackbuzz/core/di/injection_container.dart';
import 'package:trackbuzz/features/project/domain/usecase/create_project_use_case.dart';
import 'package:trackbuzz/shared/functions/message.dart';
import 'package:trackbuzz/shared/functions/save_image.dart';
import 'package:trackbuzz/shared/widgets/TextFieldCustom.dart';
import 'package:trackbuzz/shared/widgets/TextFieldDescription.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => CreateProject());
  }

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final ImagePicker _picker = ImagePicker();
  String _imagePath = '';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool loading = false;

  DecorationImage image = const DecorationImage(
    image: AssetImage('lib/assets/img/example'),
    fit: BoxFit.cover,
  );

  _load(bool value) {
    setState(() {
      loading = value;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    _changeImage(pickedFile.path);
  }

  _changeImage(String path) {
    setState(() {
      _imagePath = path;
      image = DecorationImage(image: FileImage(File(path)), fit: BoxFit.cover);
    });
  }

  Future<void> _create(String error) async {
    if (_titleController.text.isEmpty) {
      message(context, error);
      return;
    }
    _load(true);
    CreateProjectUseCase(sl()).execute(
      _titleController.text,
      _descriptionController.text.isNotEmpty
          ? _descriptionController.text
          : null,
      _imagePath.isNotEmpty
          ? await saveImage(_imagePath)
          : 'lib/assets/img/example',
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc?.translate('create_project') ?? 'Create Project',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        elevation: 0.0,
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
      floatingActionButton: loading == false
          ? FloatingActionButton(
              onPressed: () =>
                  _create(loc?.translate('error_field') ?? 'Error'),
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                CupertinoIcons.arrow_right,
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          : null,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
              top: 20,
              bottom: 10,
            ),
            width: MediaQuery.of(context).size.width * 1,
            child: Text(
              loc?.translate('title_input') ?? 'Title:',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: TextFieldCustom(controller: _titleController),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
              top: 20,
              bottom: 10,
            ),
            width: MediaQuery.of(context).size.width * 1,
            child: Text(
              loc?.translate('description_input') ?? 'Description (optional)',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: TextFieldDescription(controller: _descriptionController),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => _pickImage(),
            child: Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: BoxBorder.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                image: image,
              ),
              clipBehavior: Clip.hardEdge,
            ),
          ),
        ],
      ),
    );
  }
}
