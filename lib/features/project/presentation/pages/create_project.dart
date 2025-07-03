import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trackbuzz/features/project/data/datasource/project_datasource.dart';
import 'package:trackbuzz/features/project/data/repositories/project_repository.dart';
import 'package:trackbuzz/features/project/data/services/project_service.dart';
import 'package:trackbuzz/features/project/domain/usecase/create_project_use_case.dart';
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
  bool loading = false;

  DecorationImage image = const DecorationImage(
    image: NetworkImage(
      'https://static.wikia.nocookie.net/rezero/images/e/ea/Rem_motivando_a_Subaru.gif/revision/latest?cb=20170809212028&path-prefix=es',
    ),
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

  Future<void> _create() async {
    _load(true);
    CreateProjectUseCase(
      ProjectService(ProjectRepository(ProjectDatasource())),
    ).execute(_titleController.text, _imagePath);
    Navigator.pop(context);
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
      floatingActionButton:
          loading == false
              ? FloatingActionButton(
                onPressed: () => _create(),
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  CupertinoIcons.arrow_right,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
              : null,
      body: Column(
        children: [
          SizedBox(height: 20),
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
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 1,
                  ),
                ),
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
