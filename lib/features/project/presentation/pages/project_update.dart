import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trackbuzz/core/di/injection_container.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_state.dart';
import 'package:trackbuzz/shared/functions/save_image.dart';
import 'package:trackbuzz/shared/widgets/TextFieldDescription.dart';
import 'package:trackbuzz/shared/widgets/pre_loader.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class ProjectUpdate extends StatefulWidget {
  final int id;
  const ProjectUpdate({super.key, required this.id});

  static Route<void> route(int id) {
    return MaterialPageRoute(builder: (context) => ProjectUpdate(id: id));
  }

  @override
  State<ProjectUpdate> createState() => _ProjectUpdateState();
}

class _ProjectUpdateState extends State<ProjectUpdate> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late ProjectBloc _projectBloc;
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

  Future<void> _update() async {
    _load(true);
    _projectBloc.add(
      UpdateProject(
        title: _titleController.text,
        description: _descriptionController.text,
        img: !image.image.toString().contains('lib/assets/img/example')
            ? await saveImage(image.image.toString().split('"')[1])
            : 'lib/assets/img/example',
      ),
    );
    Navigator.pop(context, true);
  }

  @override
  void initState() {
    super.initState();
    _projectBloc = sl<ProjectBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return BlocProvider(
      create: (context) => _projectBloc..add(GetProject(id: widget.id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            loc?.translate('update_project') ?? 'Update Project',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          elevation: 0.0,
          foregroundColor: Theme.of(context).colorScheme.secondary,
        ),
        floatingActionButton: loading == false
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
                      onChanged: (value) {
                        contextBloc.read<ProjectBloc>().add(
                          UpdateTextProject(title: value),
                        );
                      },
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
              child: BlocBuilder<ProjectBloc, ProjectState>(
                builder: (contextBloc, state) {
                  if (state is ProjectLoading) {
                    return PreLoader();
                  } else if (state is ProjectLoaded) {
                    _descriptionController.text =
                        state.project.description ?? '';
                    return TextFieldDescription(
                      controller: _descriptionController,
                      onChange: (value) {
                        contextBloc.read<ProjectBloc>().add(
                          UpdateDescriptionProject(description: value),
                        );
                      },
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            BlocBuilder<ProjectBloc, ProjectState>(
              builder: (contextBloc, state) {
                if (state is ProjectLoading) {
                  return PreLoader();
                } else if (state is ProjectLoaded) {
                  if (!state.project.image.contains('lib/assets/img/example')) {
                    image = DecorationImage(
                      image: FileImage(File(state.project.image)),
                      fit: BoxFit.cover,
                    );
                  }
                  return GestureDetector(
                    onTap: () async {
                      final pickedFile = await _picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile == null) {
                        return;
                      }
                      contextBloc.read<ProjectBloc>().add(
                        UpdateImage(path: pickedFile.path),
                      );
                    },
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
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
