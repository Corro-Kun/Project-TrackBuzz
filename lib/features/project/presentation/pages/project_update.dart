import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_state.dart';
import 'package:trackbuzz/shared/widgets/pre_loader.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class ProjectUpdate extends StatefulWidget {
  final ProjectBloc bloc;
  const ProjectUpdate({super.key, required this.bloc});

  static Route<void> route(ProjectBloc bloc) {
    return MaterialPageRoute(builder: (context) => ProjectUpdate(bloc: bloc));
  }

  @override
  State<ProjectUpdate> createState() => _ProjectUpdateState();
}

class _ProjectUpdateState extends State<ProjectUpdate> {
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

  Future<void> _update() async {}

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return BlocProvider.value(
      value: widget.bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            loc?.translate('update_project') ?? 'Update Project',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          elevation: 0.0,
          foregroundColor: Theme.of(context).colorScheme.secondary,
        ),
        floatingActionButton:
            loading == false
                ? FloatingActionButton(
                  onPressed: () => _update(),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    CupertinoIcons.upload_circle_fill,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
                : null,
        body: Column(
          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => _pickImage(),
              child: BlocBuilder<ProjectBloc, ProjectState>(
                builder: (contextBloc, state) {
                  if (state is ProjectLoading) {
                    return PreLoader();
                  } else if (state is ProjectLoaded) {
                    image = DecorationImage(
                      image: FileImage(File(state.project.image)),
                      fit: BoxFit.cover,
                    );
                    return Container(
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
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
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
              child: BlocBuilder<ProjectBloc, ProjectState>(
                builder: (contextBloc, state) {
                  if (state is ProjectLoading) {
                    return PreLoader();
                  } else if (state is ProjectLoaded) {
                    _titleController.text = state.project.title;
                    return TextField(
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
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
